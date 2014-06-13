class TrucksController < ApplicationController
	
	def index
		@trucks = Truck.all
		@current_trucks = @trucks.select { |truck| truck.has_current_location? }
		# @unknown_trucks = 
	end


end