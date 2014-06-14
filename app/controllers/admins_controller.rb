class AdminsController < ApplicationController

	def index
		@pending_trucks = Truck.where.not(approved: true)
		@all_issues = Issue.all
	end

end

