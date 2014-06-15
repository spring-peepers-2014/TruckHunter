class SearchbarController < ApplicationController
	respond_to :json
  def new
  	@trucks = Truck.all.pluck(:name)
  	# @trucks.to_json
  	render :json => @trucks
  end


end

