require 'spec_helper'


feature 'Admin page' do

	before :each do
		@admin = Admin.create(username: "admin", password_digest: BCrypt::Password.create("password"))
		@truck = Truck.create(name: "burgersafs", twitter_handle: "a;dfsf", approved: false)
		visit "/admins/signin"
		fill_in "Username", :with => "admin"
		fill_in "Password", :with => "password"
    click_button "login!"
	end

	scenario "lets admin approve a truck" do
		click_link 'approved!'
		expect(Truck.last.approved).to equal(true)
	end

	scenario "lets admin delete a truck" do
    click_link 'kill truck'
    expect(Truck.all.size).to equal(0)
	end

	scenario "lets admin edit a truck" do
		click_link 'edit truck'
		uri = URI.parse(current_url)
		"#{uri.path}".should == "/trucks/#{@truck.id}/edit"
	end


end