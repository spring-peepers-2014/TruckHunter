class AdminsController < ApplicationController

	def index
		@pending_trucks = Truck.where.not(approved: true)
		@all_issues = Issue.all
	end

	def add_truck

	end

	def kill_truck
	end


end

