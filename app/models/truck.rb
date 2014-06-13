class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true)
		# p trucks_tweets.text


		trucks_tweets.each do |tweet|

			p JSON.parse(tweet.to_json)["user"]["geo_enabled"]
			# Tweet.create(body: tweet.tweet, tweet_time: tweet.created_at)
		end
	end

	def has_current_location?
		return false if self.latitude.nil? || self.longitude.nil?
		time_since_update = Time.now - self.updated_at

		if time_since_update > 14400 
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
