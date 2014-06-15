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
		p trucks_tweets.length
		recent_tweets = trucks_tweets.select { |tweet| (Time.now - tweet.created_at) < 86400 }
		p recent_tweets.length

		recent_tweets.each do |tweet|
			p "these are recent tweets"
			p tweet.text

			new_tweet = self.tweets.build(body: tweet.text, tweet_time: tweet.created_at)
			p "is the tweet valid?"
			p new_tweet.valid?

			new_tweet.save
			p new_tweet.save


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

		return time_since_update < 14400 ###4 hour interval

	end


	def self.geo_json

		ActiveSupport::TimeZone[-8]
		range = (Time.now.midnight - 4.hours)..Time.now.midnight
		time_range = ((Time.now - 4.hours)..Time.now)
		p Time.now.midnight
		p time_range
		p range

		@trucks = Truck.where.not(longitude: -74.0059413, latitude: 40.7127837).where('updated_at > ?', 4.hours.ago)
		#(longitude: -74.0059413, latitude: 40.7127837)
		p @trucks
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
