require 'spec_helper'

describe TweetsController do

  let!(:tweet) { FactoryGirl.build(:tweet) }

  context "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns @todos to Todo.all" do
      get :index
      expect(assigns(:todos)).to eq Todo.all
    end

    it "assigns @todo to Todo.new" do
      get :index
      expect(assigns(:todo)).to be_a_new Todo
    end

  end

  context "#show" do
    it "is successful" do
      get :show, :id => todo.id
      expect(response).to be_success
    end

    it "assigns @todo to todo" do
      get :show, :id => todo.id
      expect(assigns(:todo)).to eq todo
    end
  end

  context "#create" do
    it "with valid attributes" do
      expect {
        post :create, :todo => attributes_for(:todo)
        expect(response).to be_success
      }.to change { Todo.count }.by(1)
    end

    it "with invalid attributes" do
      expect {
        post :create
        expect(response.status).to eq 422
      }.to_not change { Todo.count }
    end
    it "with existing title" do
      todo = create :todo
      expect {
        post :create, :todo => { :title => todo.title }
        expect(response.status).to eq 422
      }.to_not change { Todo.count }
    end
  end

  context "#edit" do
    it "is successful" do
      get :edit, :id => todo.id
      expect(response).to be_success
    end

    it "assigns @todo to todo" do
      get :edit, :id => todo.id
      expect(assigns(:todo)).to eq todo
    end
  end

  context "#update" do
    it "with valid attributes" do
      expect {
        put :update, :id => todo.id, :todo => { :title => "Work" }
        expect(response).to be_success
      }.to change { todo.reload.title }.from(todo.title).to("Work")
    end
    it "with invalid attributes" do
      expect {
        put :update, :id => todo.id, :todo => { :title => '' }
        expect(response.status).to eq 422
      }.to_not change { todo.reload.title }
    end
  end

  context "#destroy" do
    it "is successful" do
      delete :destroy, :id => todo.id
      expect(response).to be_success
    end

    it "destroys the todo" do
      expect {
        delete :destroy, :id => todo.id
      }.to change { Todo.count }.by(-1)
    end
  end
end
