class SearchbarController < ApplicationController

	respond_to :json

	def create
		@truck = Truck.find_by_name(params[:name])
		if @truck 
			@last_tweet = @truck.tweets.last
			render partial: "index", locals: {truck: @truck, last_tweet: @last_tweet}
		else
			render partial: "does_not_exist"
		end
	end

	def new
		@trucks = Truck.where(approved: true).pluck(:name)
		render :json => @trucks
	end

end

