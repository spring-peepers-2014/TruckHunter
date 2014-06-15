require 'spec_helper'

describe TrucksController, :type => :controller do

  let!(:truck) { FactoryGirl.build :truck }

  describe "POST #create" do
    it "creates a truck successfully" do
      post :create, truck: FactoryGirl.attributes_for(:truck)
      expect(response).to be_success
    end

  describe "DELETE #destroy" do
  	before :each do
  		@truck = :truck
  	end

  	it "deletes the truck" do
  		expect{
  			delete :destroy, @truck
  		}.to change(Truck,:count).by(-1)
  	end
  end

  end
end
