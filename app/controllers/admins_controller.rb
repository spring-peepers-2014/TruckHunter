class AdminsController < ApplicationController

	def index
		@pending_trucks = Truck.where.not(approved: true)
	end

	#this shows the admin login page
	def new
		@admin = Admin.new
	end

	def create
		admin = Admin.first
		if admin && admin.authenticate
			session[:admin] = true
		else
			render :new
		end
	end


	def destroy
		session.clear
		redirect_to root_path
	end


end

