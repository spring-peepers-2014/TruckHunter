class SearchbarController < ApplicationController

	respond_to :json


	def create
		@truck = Truck.find_by_name(params[:name])
		# if @truck
		render partial: "index", locals: {truck: @truck}
	end

# this is loading the geo-json marker objects on map
	def new
		@trucks = Truck.all.pluck(:name)
		render :json => @trucks
	end


end

