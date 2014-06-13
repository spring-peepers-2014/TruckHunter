Rails.application.routes.draw do

  root "trucks#index"

  resources :trucks do
    resources :tweets
  end

end
