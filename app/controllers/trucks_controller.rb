class TrucksController < ApplicationController
  respond_to :json

  def index
	# @trucks = Truck.where(approved: true, active: true)
	# @current_trucks = @trucks.select { |truck| truck.has_current_location? }
	# @unknown_trucks = @trucks - @current_trucks

  render :json => Truck.geo_json
  end


end

