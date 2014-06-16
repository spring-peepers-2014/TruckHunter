class Truck < ActiveRecord::Base
	include LocationHunter

	has_many :tweets

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	before_save :geocode


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true).reverse
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
			else
				self.get_coordinates(tweet.text)
			end

		end
	end


	def has_current_location?
		(Time.now - self.location_last_updated) < 14400 ###4 hour interval
	end


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


	def self.geo_json
		@trucks = trucks_to_pin
		@trucks_false = Truck.where(longitude: -74.0059413, latitude: 40.7127837)
		@trucks -= @trucks_false

		p "hope it gets through self.geo_json"

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
					json.set! :'marker-color', "#6c6c6c"
					json.set! :'marker-size', "small"
					json.set! :'marker-symbol', "bus"
				end
			end
		end

	end
end
