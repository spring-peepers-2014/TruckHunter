Rails.application.routes.draw do

  root "home#index"

  resources :trucks, constraints: {:format => /json/} do
    resources :tweets, constraints: {:format => /json/}
  end

end
