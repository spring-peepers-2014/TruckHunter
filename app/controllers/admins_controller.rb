class AdminsController < ApplicationController

	def index
		@pending_trucks = Truck.where.not(approved: true)
	end

	#this shows the admin login page
	def new
		@admin = Admin.new
	end

	def create
		admin = Admin.find_by_username(params[:admin][:username])

		if admin && admin.authenticate(params[:admin][:password])
			session[:admin] = true
			redirect_to admins_page_path
		else
			redirect_to admins_signin_path
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end

	private

	def admin_params
    	params.require(:admin).permit(:username, :password)
	end
end

