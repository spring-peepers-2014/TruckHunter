class Tweet < ActiveRecord::Base
	belongs_to :truck

	validates :body, presence: true, uniqueness: true
	validates :tweet_time, presence: true
end
