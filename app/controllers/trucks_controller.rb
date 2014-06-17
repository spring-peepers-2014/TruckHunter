class TrucksController < ApplicationController
	respond_to :json
	# before_filter :load_truck, :except => [:index, :create]

  def index
    @newtruck = Truck.new
    @message = "know a truck?"
  end

    
  	@trucks = Truck.where(approved: true, active: true)
  	@current_trucks = @trucks.select { |truck| truck.has_current_location? }
	
	 @unknown_trucks = @trucks - @current_trucks

  	@unknown_trucks.each do |truck|
		if truck.tweets_last_fetched.nil?
  			time_since_last_tweet = 9000
  		else
  			time_since_last_tweet = Time.now - truck.tweets_last_fetched
  		end

  		truck.fetch_tweets! if time_since_last_tweet > 3600
    end
    
		@updated_trucks = @unknown_trucks.select { |truck| truck.has_current_location? }

  def new
    render :json => Truck.geo_json
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.save
    render :json => Truck.geo_json
  end

  def addtruck
    twitter_handle = params[:truck][:twitter_handle].gsub('@','')
    @newtruck = Truck.create(name: params[:truck][:name], twitter_handle: twitter_handle, approved: false)
    @message = "thanks! we'll check it soon!"
    render :index
  end

  def approve
    Truck.find(params[:id]).update(approved: true)
    redirect_to :back
  end

  def edit
    @truck = Truck.find(params[:id])
  end


  def update
    truck = Truck.find(params[:id])
    truck.update_attributes(truck_params)
    truck.save

    redirect_to admins_path

  end

  def destroy
    Truck.find(params[:id]).destroy

    redirect_to admins_path
  end



  private

  def truck_params
    params.require(:truck).permit(:name, :twitter_handle)
  end

   def load_truck
    @truck = Truck.find params[:id]
  end


end
