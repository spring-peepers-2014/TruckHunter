require 'spec_helper'

describe TrucksController do

  let!(:truck) { FactoryGirl.build(:truck) }

  context "#create" do
    it "creates a new truck with name and twitter handle" do
      # expect {
      #   post :create, :todo_id => todo.id, :task => attributes_for(:task)
      #   expect(response).to be_success
      # }.to change { Task.count }.by(1)
    end
    it "doesn't create a truck already in the database" do
      # expect {
      #   post :create, :todo_id => todo.id, :task => { :body => nil }
      #   expect(response.status).to eq 422
      # }.to_not change { Task.count }
    end
  end
end
