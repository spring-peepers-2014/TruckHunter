class TrucksController < ApplicationController
	respond_to :json
	before_filter :load_truck, :except => [:index, :create]

  def index
  	@trucks = Truck.where(approved: true, active: true)
  	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
  	@unknown_trucks = @trucks - @current_trucks

  	@unknown_trucks.each do |truck|
  		last_tweet = truck.tweets.last

  		if last_tweet.nil?
  			time_since_last_tweet = 9000 ### if no tweets
  		else
  			time_since_last_tweet = Time.now - last_tweet.created_at
  		end

  		if time_since_last_tweet > 3600
  			truck.fetch_tweets!
  			truck.update_location
  		end

  		@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }
    end

  end

  def new
  	render :json => Truck.geo_json
  end

  def create
  	@truck = Truck.new params[:truck]
  	@truck.save
  end

  private
  def load_truck
    @truck = Truck.find params[:id]
  end

end

