Rails.application.routes.draw do

  devise_for :users
  # devise_for :users
  root to: 'pages#home'
  get '/search_result', to: 'artists#index'
  get '/search_results/artist', to: 'artists#show'

    resources :consumers, only: [:destroy, :index]
    resources :consumer_events do
      resources :artist_requests, only: [:create]
    end

    resources :artists do
      resources :consumer_requests
    end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
