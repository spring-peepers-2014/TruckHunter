class TrucksController < ApplicationController
  respond_to :json

  def index
	@trucks = Truck.where(approved: true, active: true)
	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	@unknown_trucks = @trucks - @current_trucks

	@unknown_trucks.each do |truck|
		last_tweet = truck.tweets.last
		time_since_last_tweet = Time.now - last_tweet.created_at

		if time_since_last_tweet > 3600
			truck.fetch_tweets!
			truck.update_location
		end
	end

	@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }

  render :json => Truck.geo_json
  
  end

  def new

  end

  def create
  	
  end

end

