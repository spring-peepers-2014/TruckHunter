class Truck < ActiveRecord::Base
	has_many :tweets
	has_many :issues

	validates :name, presence: true
	validates :twitter_handle, uniqueness: true


	def fetch_tweets!
		trucks_tweets = CLIENT.user_timeline(self.twitter_handle, count: 5)
		p trucks_tweets
		
		trucks_tweets.each do |tweet|
			Tweet.create(body: tweet.tweet, tweet_time: tweet.created_at)
		end
	end

end
