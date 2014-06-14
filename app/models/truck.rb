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
				new_tweet.location = geocode_coordinates(tweet.text)
			end

			p "*****************************"
			p new_tweet.body

			new_tweet.save
			
			p "*****************************"
			p new_tweet.body
		end
	end

	def update_location
		tweets_with_location = self.tweets.where.not(location: nil)
		if tweets_with_location != []
			p tweets_with_location.last.location
			geocode_coordinates(tweets_with_location.last.location)
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


	def parse_tweet(tweet)
		my_match = /(@|at|on)\s+((?:\S+\s)?\S*(and|&)\S*(?:\s\S+)?)|\S\d+\s\b\w+\b\s(Avenue|Ave|Street|St)|\A?^?\d+\s(\b\w+\b\s)+(Avenue|Ave|Street|St)|(\b\w+\b\s){2}Park|(\b\w+\b\s)(St|Street)\sand?\s(\b\w+\b\s)(St|Street)/i.match(tweet).to_s
	end

	def clean_match(match)
		match = parse_tweet(match)

		match = /seaport/i.match(match).to_s if match == ""
				
		match.gsub!("(", "")
		match.gsub!(")", "")
		match.gsub!("at ", "")
		match.gsub!(" on ", "")
		match.gsub!("@", "")

		return false if match == ""
		match
	end

	def geocode_coordinates(location)
		location = clean_match(location)

		return false if location == false

		geo_data = Geocoder.search(location + ", new york city").first
		latitude = geo_data.geometry["location"]["lat"]
		longitude = geo_data.geometry["location"]["lng"]

		return false if [latitude, longitude] == [40.7127837, -74.0059413]
		
		p location
		p "*" * 50

		self.latitude = latitude
		self.longitude = longitude

		[latitude, longitude].join(",")
	end


	def self.geo_json

		@trucks = Truck.all

		Jbuilder.encode do |json|
			json.array! @trucks do |truck|
				json.type "Feature"
				json.geometry do
					json.type "Point"
					json.coordinates [truck.latitude,truck.longitude]
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
