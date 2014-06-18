class TweetManager

	def self.fetch_tweets!(twitter_handle)
		trucks_tweets = CLIENT.user_timeline(twitter_handle, count: 5, exclude_replies: true)
		return trucks_tweets.select { |tweet| (Time.now - tweet.created_at) < 86400 }
	end

	def self.search_tweets(truck)
		tweets = fetch_tweets!(truck.twitter_handle)
		truck.update(tweets_last_fetched: Time.now)

		tweets.each do |tweet|
			build_tweet(truck, tweet)
      		get_profile_img(truck, tweet)
     		get_geolocation_data(truck, tweet)
		end

	rescue Twitter::Error::Forbidden => error
		puts "*"*70
		puts "ERROR: #{error}"
		puts "Are you authorized with Twitter to use this application?"
		puts "*"*70
		return false
		
	end

	def self.build_tweet(truck, tweet)
		new_tweet = truck.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
		new_tweet.save
	end

	def self.get_profile_img(truck, tweet)
		profile_img = JSON.parse(tweet.to_json)["user"]["profile_image_url"]
    	truck.update(profile_img_url: profile_img)
	end

  def self.get_geolocation_data(truck, tweet)
    geo_enabled = JSON.parse(tweet.to_json)["geo"]

    if geo_enabled
      lat, long = geo_enabled["coordinates"]
      truck.update_attributes(latitude: lat, longitude: long, location_last_updated: Time.now)
    end
    
    location = LocationHunter.get_coordinates(tweet.text)
    truck.update_attributes(address: "#{location}, New York City", location_last_updated: Time.now) if location
  end

end

