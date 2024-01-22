Rails.application.routes.draw do
  resources :shortened_urls

  root to: 'shortened_urls#new'
  get '/top-100', to: 'shortened_urls#index'
  get '/:short_url', to: 'shortened_urls#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
