Rails.application.routes.draw do

  root "home#index"

  resources :trucks do
    resources :tweets
  end

end
