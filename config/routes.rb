Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root "home#index"

  resources :trucks, constraints: {:format => /json/} do
    resources :tweets, constraints: {:format => /json/}
  end

  resources :admins

end
