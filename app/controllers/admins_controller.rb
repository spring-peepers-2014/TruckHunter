class AdminsController < ApplicationController

	def index
		@pending_trucks = Truck.where.not(approved: true)
	end

	def add_truck

	end

	def kill_truck
	end


end

