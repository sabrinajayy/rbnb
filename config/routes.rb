Rails.application.routes.draw do

  devise_for :users
  # devise_for :users
  root to: 'pages#home'
  get '/search_results', to: 'artists#search'
  get '/search_results/artist', to: 'artists#show'

    resources :consumers
    resources :consumer_events do
      resources :artist_requests, only: [:create]
    end



    resources :artists do
      resources :consumers_requests
    end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
