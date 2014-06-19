require 'singleton'

class TwitterClient
	include Singleton
	attr_reader :client

	def initialize
		@client = Twitter::REST::Client.new do |config|
    		config.consumer_key = ENV['CONSUMER_KEY']
    		config.consumer_secret = ENV['CONSUMER_SECRET']
 		end
  	end

end
