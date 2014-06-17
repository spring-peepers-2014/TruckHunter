class SearchbarController < ApplicationController

	respond_to :json


	def create
		@truck = Truck.find_by_name(params[:name])
		if @truck
			render partial: "index", locals: {truck: @truck}
		else
			render partial: "does_not_exist"
		end
	end

	def new
		@trucks = Truck.where(approved: true).pluck(:name)
		render :json => @trucks
	end


end

