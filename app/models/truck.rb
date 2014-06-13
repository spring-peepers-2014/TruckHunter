class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true).reverse

		trucks_tweets.each do |tweet|
			new_tweet = self.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
			geo_enabled = JSON.parse(tweet.to_json)["user"]["geo_enabled"]

			if geo_enabled
				coordinates = JSON.parse(tweet.to_json)["geo"]["coordinates"].join(",") #coordinates as "lat,lng"
				new_tweet.location = coordinates
			else
				# LocationHunter.parse_for_location(tweet.text)
				##### parse tweet text for location	#####
			end

			new_tweet.save

		end
	end

	def has_current_location?
		return false if self.latitude.nil? || self.longitude.nil?
		time_since_update = Time.now - self.updated_at

		if time_since_update > 14400 ###4 hour interval
			false
		else
			true
		end
	end


	def geocode_coordinates(location)
		geo_data = Geocoder.search(location).first
		latitude = geo_data.geometry["location"]["lat"]
		longitude = geo_data.geometry["location"]["lng"]

		self.latitude = latitude
		self.longitude = longitude
	end


end
