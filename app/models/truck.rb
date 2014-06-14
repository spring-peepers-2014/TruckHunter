class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true).reverse

		trucks_tweets.each do |tweet|

			new_tweet = self.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
			geo_enabled = JSON.parse(tweet.to_json)["geo"]

			if geo_enabled
				coordinates = JSON.parse(tweet.to_json)["geo"]["coordinates"].join(",") #coordinates as "lat,lng"
				new_tweet.location = coordinates
			else
				# LocationHunter.parse_for_location(tweet.text)
				##### parse tweet text for location	#####
				p "no coordinates"
				p JSON.parse(tweet.to_json)
			end

			new_tweet.save
		end
		
	end

	def update_location
		tweets_with_location = self.tweets.where.not(location: nil)
		p tweets_with_location.last.location
		geocode_coordinates(tweets_with_location.last.location)
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




	def parse_tweet(tweet)
		my_match = /(@|at|on)\s+((?:\S+\s)?\S*(and|&)\S*(?:\s\S+)?)/.match(tweet).to_s

		if my_match == ""
			my_match = /seaport/i.match(tweet).to_s
		end

		my_match
	end

	def clean_match(match)
		short_string = match
		short_string.gsub!("at", "")
		short_string.gsub!("on", "")
		short_string.gsub!("@", "")
		short_string
	end

	def geocode_coordinates(location)
		geo_data = Geocoder.search(location + ", new york city").first
		latitude = geo_data.geometry["location"]["lat"]
		longitude = geo_data.geometry["location"]["lng"]

		if [latitude, longitude] == [40.7127837, -74.0059413]
			return false
		else
			self.latitude = latitude
			self.longitude = longitude
		end

		[latitude, longitude]
	end


end
