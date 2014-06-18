class ActiveTrucksManager

	def self.trucks_to_pin
		@trucks = Truck.where(approved: true, active: true)
		@current_trucks = @trucks.select { |truck| has_current_location?(truck) }
	 	@unknown_trucks = @trucks - @current_trucks

		@unknown_trucks.each do |truck|
			TweetManager.search_tweets(truck) if time_since_last_tweet(truck) > 3600
  		end

		@updated_trucks = @unknown_trucks.select { |truck| has_current_location?(truck) }
  		@trucks = @updated_trucks + @current_trucks

		@trucks_stale_tweets = @trucks.select { |truck| truck.tweets.last.tweet_time < Time.now.midnight }
		@trucks_false = Truck.where(longitude: -74.0059413, latitude: 40.7127837)

		@trucks -= @trucks_false
		@trucks -= @trucks_stale_tweets
	end

	def self.has_current_location?(truck)
		return false if truck.latitude.nil? || truck.longitude.nil?
		(Time.now - truck.location_last_updated) < 14400 ###4 hour interval
	end

	def self.time_since_last_tweet(truck)
		if truck.tweets_last_fetched.nil?
			time_since_tweet = 9000
		else
			time_since_tweet = Time.now - truck.tweets_last_fetched
		end
		return time_since_tweet
	end

end
