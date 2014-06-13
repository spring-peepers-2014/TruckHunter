class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true)
		# p trucks_tweets.text

		# p Geocoder.search("21st and 5th new york").first

		trucks_tweets.each do |tweet|

			# p "Geo enabled:" JSON.parse(tweet.to_json)["user"]["geo_enabled"]
			# Tweet.create(body: tweet.tweet, tweet_time: tweet.created_at)
		end
		
	end

	def has_current_tweets?
		# @tweets = self.tweets.last
	end


end
