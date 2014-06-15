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
  			time_since_last_tweet = 9000
  		else
  			time_since_last_tweet = Time.now - last_tweet.created_at
  		end

  		truck.fetch_tweets! if time_since_last_tweet > 3600
    end
		@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }
  end

  def new
  	render :json => Truck.geo_json
  end

  def create
  	@truck = Truck.new(truck_params)
  	@truck.save
    render :json => Truck.geo_json
  end

  private
  def load_truck
    @truck = Truck.find params[:id]
  end

  def truck_params
    params.require(:truck).permit(:name, :twitter_handle)
  end

end
