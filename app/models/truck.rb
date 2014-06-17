class Truck < ActiveRecord::Base
	include LocationHunter

	has_many :tweets

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	before_save :geocode


	before_create :downcase


	def downcase
		self.name.downcase!
	end

  # How is this a concern of a truck, shouldn't there be a TweetFetcher class?
  # This is bad OO.
	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true)
		self.update(tweets_last_fetched: Time.now)

		recent_tweets = trucks_tweets.select { |tweet| (Time.now - tweet.created_at) < 86400 }

		recent_tweets.each do |tweet|
			new_tweet = self.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
			new_tweet.save
			geo_enabled = JSON.parse(tweet.to_json)["geo"]

			if geo_enabled
				coordinates = JSON.parse(tweet.to_json)["geo"]["coordinates"]

				self.update(latitude: coordinates[0])
				self.update(longitude:  coordinates[1])
				self.update(location_last_updated: Time.now)
				return
			else
				location_set = self.get_coordinates(tweet.text)
				return if location_set
			end
			
		end
	end


  # How is this concern of a Truck?  A truck has wheels and goes vrooom vroom.
  # It doesn't know its latitude update occurred within the last 4 hours.
	def has_current_location?
		return false if self.latitude.nil? || self.longitude.nil?
		(Time.now - self.location_last_updated) < 14400 ###4 hour interval
	end


  # Again, not the concern of a Truck class or a given truck.  Maybe it's the
  # concern of an ActiveTrucksFetcher who offers a single public method called
  # #trucks.  This is an implementation of a design pattern called "Method
  # Object: ask about it."
	def self.trucks_to_pin
		@trucks = Truck.where(approved: true, active: true)
  		@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	 	@unknown_trucks = @trucks - @current_trucks

  		@unknown_trucks.each do |truck|
			if truck.tweets_last_fetched.nil?
  				time_since_last_tweet = 9000
  			else
  				time_since_last_tweet = Time.now - truck.tweets_last_fetched
  			end
  			truck.fetch_tweets! if time_since_last_tweet > 3600
    	end

		@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }
    	@trucks_to_pin = @updated_trucks + @current_trucks
	end


  # It seems to me that htis method is doing too much.
  #
  # 1.  It's rendering a Truck to jSON
  # 2.  It's filtering out a bad truck.
  #
  # If you had the ActiveTrucksFinder, as above, you could put filtration into
  # that.
  #
  # Now, as to the question of a Truck rendering itself to JSON, there's a
  # design pattern called the Presenter which is used to present a model into a
  # serialized format (e.g. JSON, xml, etc.).  Ask about it.
	def self.geo_json
		@trucks = trucks_to_pin
		@trucks_false = Truck.where(longitude: -74.0059413, latitude: 40.7127837)
		@trucks -= @trucks_false

		Jbuilder.encode do |json|
			json.array! @trucks do |truck|
				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck.longitude, truck.latitude]
				end
				json.properties do
					json.title truck.name
					json.description  "<a href='http://twitter.com/#{truck.twitter_handle}'>@"+truck.twitter_handle+"</a>
					<br><i>"+truck.tweets.last.body+"</i>"
					json.icon do
						json.iconUrl "/assets/foodTruck.png"
						json.iconSize [28, 22]
						json.iconAnchor [25, 25]
						json.popupAnchor [0, -25]
						json.className "dot"
					end
				end
			end
		end

	end
end
