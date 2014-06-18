class Truck < ActiveRecord::Base

	has_many :tweets

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	
	before_save :geocode
	
	before_save do
		self.name.downcase!
	end

	def has_current_location?
		return false if self.latitude.nil? || self.longitude.nil?
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
			 TweetManager.search_tweets(truck) if time_since_last_tweet > 3600
  		end

		@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }
  		@trucks_to_pin = @updated_trucks + @current_trucks
	end


	def self.geo_json
		@trucks = trucks_to_pin

		@trucks_stale_tweets = @trucks.select { |truck| truck.tweets.last.tweet_time < Time.now.midnight }
		@trucks_false = Truck.where(longitude: -74.0059413, latitude: 40.7127837)

		@trucks -= @trucks_false
		@trucks -= @trucks_stale_tweets

		Jbuilder.encode do |json|
			json.array! @trucks do |truck|
				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck.longitude, truck.latitude]
				end
				json.properties do
					json.title truck.name
					json.description  "<img src='#{truck.profile_img_url}' /><br><a href='http://twitter.com/#{truck.twitter_handle}'>@"+truck.twitter_handle+"</a>
					<br><i>"+truck.tweets.last.body+"</i><br>Tweeted on "+truck.tweets.last.tweet_time.in_time_zone.strftime("%b %e, %l:%M %p")
					
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
