class ActiveTrucksManager

	def has_current_location?(truck)
		return false if truck.latitude.nil? || truck.longitude.nil?
		(Time.now - truck.location_last_updated) < 14400 ###4 hour interval
	end

	# def self.trucks_to_pin
	# 	@trucks = Truck.where(approved: true, active: true)
	# 	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	#  	@unknown_trucks = @trucks - @current_trucks

	# 	@unknown_trucks.each do |truck|
	# 		if truck.tweets_last_fetched.nil?
	# 			time_since_last_tweet = 9000
	# 		else
	# 			time_since_last_tweet = Time.now - truck.tweets_last_fetched
	# 		end
	# 		 TweetManager.search_tweets(truck) if time_since_last_tweet > 3600
 #  		end

	# 	@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }
 #  		@trucks_to_pin = @updated_trucks + @current_trucks
	# end

end