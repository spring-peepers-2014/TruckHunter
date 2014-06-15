Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root :to => "trucks#index"

  resources :trucks, constraints: {:format => /json/} do

  end

  resources :admins, only: [:index, :new, :create]

  get '/trucks/:id/approve' => "trucks#approve", :as => 'truck_approve'

  get '/admins_page' => 'admins#index', :as => 'admins_page'
  get '/admins/signin' => 'admins#new', :as => :signin
  post '/admins/signin' => 'admins#create'
  delete '/admins/logout' => 'admins#destroy', :as => :logout

  post '/addtruck' => 'trucks#addtruck', :as => 'make_truck'

end
