class TrucksController < ApplicationController
	respond_to :json

  def index
    @newtruck = Truck.new
    @message = "know a truck?"
  end

  def new
    render :json => TruckPresenter.truck_pins
  end

  def create
    @truck = Truck.new(truck_params)
    @truck.save
    render :json => TruckPresenter.truck_pins
  end

  def addtruck
  
    twitter_handle = params[:truck][:twitter_handle].gsub('@','')
    @newtruck = Truck.create(name: params[:truck][:name], twitter_handle: twitter_handle, approved: false)
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
    truck.update_attributes(location_last_updated: Time.now)
    truck.save

    redirect_to admins_path
  end

  def destroy
    Truck.find(params[:id]).destroy

    redirect_to admins_path
  end



  private

  def truck_params
    params.require(:truck).permit(:name, :twitter_handle, :address, :location_last_updated)
  end

   def load_truck
    @truck = Truck.find params[:id]
  end


end
