require 'spec_helper'

describe TrucksController, :type => :controller do

  let!(:truck) { FactoryGirl.build :truck }

  describe "POST #create" do
    it "is successful" do
        post :create, truck: FactoryGirl.attributes_for(:truck)
        expect(response).to be_success
    end
    it "doesn't create a truck with a handle that is already in the database" do
    end
  end
end
