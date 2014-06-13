class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5, exclude_replies: true)
		# p trucks_tweets.text

		# p Geocoder.search("21st and 5th from 9:00-3:00 new york").first

		trucks_tweets.each do |tweet|
			p tweet.to_json
			# Tweet.create(body: tweet.tweet, tweet_time: tweet.created_at)
		end
	end

end
