require 'spec_helper'

describe TrucksController, :type => :controller do

  let!(:truck) { FactoryGirl.build :truck }

  describe "POST #create" do
    xit "is successful" do
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

  describe "GET #edit" do
  	it "should redirect back" do
      # Funny.
  		x = Truck.create(name: "please", twitter_handle: "work")
    	get :edit, id: x.id
    	response.should be_success
  	end
  end

  # OK don't commit commented out code.  It makes you look sloppy.
  #
  # But my question is, why did you have to comment out so much code all of a
  # sudden?
  #
  # As a baseline you could at least `xit`
  # the tests and say "Hey I'm working on debugging this."  These tests are
  # failing and have good data for you.....


   describe "GET #approve" do
     xit "should redirect back" do
       x = Truck.create(name: "please", twitter_handle: "work")
       get :approve, id: x.id
       response.should be_success
     end
   end

   describe "DELETE #destroy" do
     # You have a bug here and the tests want to help -- and it's **REALLY
     # SIMPLE**  don't comment tests out.  You're only hurting yourselves.
     xit "it deletes a truck" do
       x = Truck.create(name: "please", twitter_handle: "work")
       delete :destroy, id: x.id
       expect(response).to be_success
     end
    end

   describe "PATCH #update" do
     before :each do
       @truck = Truck.create(name: 'cmon', twitter_handle: 'now')
     end

     xit "locates the requested @truck" do
       patch :update, id: @truck.id
       expect(assigns(@truck)).to eq(@truck)
     end
   end

end
