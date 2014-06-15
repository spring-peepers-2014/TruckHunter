require 'spec_helper'

describe TrucksController, :type => :controller do

  let!(:truck) { FactoryGirl.build :truck }

  describe "POST #create" do
    it "is successful" do
      post :create, truck: FactoryGirl.attributes_for(:truck)
      expect(response).to be_success
    end
  end

  describe "GET #index" do
  	it "gets the index" do
  		get :index
  		expect(response).to render_template :index
  	end
  end

  describe "GET #new" do
  	it "should render json successfully" do
    	get :new, :format => :json
    	response.should be_success
  	end
  end

  describe "GET #approve" do
  	it "should redirect back" do
    	get :approve
    	response.should be_success
  	end
  end

end
