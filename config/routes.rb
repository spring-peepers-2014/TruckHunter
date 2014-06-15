Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root "trucks#index"

  resources :trucks, constraints: {:format => /json/} do

  end

  resources :admins, only: [:index]

  get '/trucks/:id/approve' => "trucks#approve", :as => 'truck_approve'



end
