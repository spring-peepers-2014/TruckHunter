require 'spec_helper'

describe TrucksController do

  let!(:truck) { create :truck }

  context "#create" do
    it "creates a new truck with name and twitter handle" do
      expect {
        post :create, :truck => attributes_for(:truck)
        expect(response).to be_success
      }.to change { Truck.count }.by(1)
    end
    it "doesn't create a truck with a handle that is already in the database" do
    end
  end
end
