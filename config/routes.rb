Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root "trucks#index"

  resources :trucks, constraints: {:format => /json/} do

  end

  resources :admins, only: [:index, :new, :create, :destroy]

  get '/trucks/:id/approve' => "trucks#approve", :as => 'truck_approve'
  get '/admins/signin' => 'admins#signin', :as => 'admins_signin'




  get '/signin' => 'admins#new', :as => :signin
  post '/signin' => 'admins#create'
  delete '/logout' => 'admins#destroy'

end
