class SearchbarController < ApplicationController
	respond_to :json
  def new
  	@trucks = Truck.all.pluck(:name)
  	render :json => @trucks
  end


end

