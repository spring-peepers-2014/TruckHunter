require 'spec_helper'


feature 'Admin page' do

	before :each do
		@admin = Admin.create(username: "admin", password_digest: "password")
		@truck = Truck.create(name: "burgersafs", twitter_handle: "a;dfsf", approved: false)
	end

	scenario "lets admin approve a truck" do
		visit admins_page_path
		expect(click_link 'approved!').to change(@truck, :approved == true)
	end

	scenario "lets admin delete a truck" do
		visit admins_page_path
		expect(click_link 'kill truck').to change(Truck.all, :count).by(-1)
	end

	scenario "lets admin edit a truck" do
		visit admins_page_path
		# save_and_open_page
		expect(click_link 'edit_truck').to redirect_to edit_truck_path(@truck.id)
	end


end