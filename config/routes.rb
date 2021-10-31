Rails.application.routes.draw do
  namespace :api do
    resources :posts, only: [:index]
    resources :ping, only: [:index]
  end
end
