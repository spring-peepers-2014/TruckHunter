FactoryGirl.define do
	factory :tweet do
		body "This is a tweet! We're at 21st and 5th today."
		tweet_time Time.now-15000
	end	
end