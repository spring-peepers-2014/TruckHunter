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
		recent_tweets = trucks_tweets.select { |tweet| Time.now - tweet.created_at < 86400 }

		recent_tweets.each do |tweet|
			new_tweet = self.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
			new_tweet.save

			geo_enabled = JSON.parse(tweet.to_json)["geo"]
			if geo_enabled
				coordinates = JSON.parse(tweet.to_json)["geo"]["coordinates"]
				
				self.latitude = coordinates[0]
				self.longitude =  coordinates[1]
				# return
			else
				self.get_coordinates(tweet.text)
				# coordinates = self.get_coordinates(tweet.text)

				# if coordinates
				# 	p coordinates
				# 	p "you got here for this tweet"
				# 	self.update(latitude: coordinates[0])
				# 	self.update(longitude: coordinates[1])
				# 	p self.latitude
				# 	p self.longitude
				# 	return
				# end
			end

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


	def self.geo_json

		@trucks = Truck.where("address IS NOT NULL")

		Jbuilder.encode do |json|
			json.array! @trucks do |truck|
				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck.longitude, truck.latitude]
				end
				json.properties do
					json.title truck.name
					json.description "Twitter Handle: " + truck.twitter_handle
					json.set! :'marker-color', "#6c6c6c"
					json.set! :'marker-size', "small"
					json.set! :'marker-symbol', "bus"
				end
			end
		end

	end
end
