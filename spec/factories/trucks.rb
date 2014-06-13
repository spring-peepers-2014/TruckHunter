FactoryGirl.define do
	factory :truck do
		name "Bob's Burgers"
		twitter_handle "VeganLunchTruck"
		tweet_time Time.now-15000
	end	
end