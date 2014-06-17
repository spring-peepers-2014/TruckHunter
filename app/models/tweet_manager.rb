class TweetManager

	def self.fetch_tweets!(twitter_handle)
		trucks_tweets = CLIENT.user_timeline(twitter_handle, count: 5, exclude_replies: true)
		recent_tweets = trucks_tweets.select { |tweet| (Time.now - tweet.created_at) < 86400 }
	end

	def self.search_tweets(truck)
		tweets = fetch_tweets!(truck.twitter_handle)

		tweets.each do |tweet|
			build_tweet(truck, tweet)
			geo_enabled = get_geolocation_data(tweet)
			profile_img = get_profile_img(tweet)

			truck.update(profile_img_url: profile_img)

			if geo_enabled
				lat, long = geo_enabled["coordinates"]
				truck.update_attributes(latitude: lat, longitude: long, location_last_updated: Time.now)
				return
			else
				location = LocationHunter.get_coordinates(tweet.text)
				if location
					truck.update_attributes(address: "#{location}, New York City", location_last_updated: Time.now)
					return
				end
			end			
		end
	end

	def self.build_tweet(truck, tweet)
		new_tweet = truck.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
		new_tweet.save
	end

	def self.get_geolocation_data(tweet)
		JSON.parse(tweet.to_json)["geo"]
	end

	def self.get_profile_img(tweet)
		JSON.parse(tweet.to_json)["user"]["profile_image_url"]
	end
end

