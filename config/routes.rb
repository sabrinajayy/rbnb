Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: "registrations"}
  # devise_for :users
  root to: 'pages#home'
  get '/search_results', to: 'artists#search'
  get '/search_results/artist', to: 'artists#show'

  get '/artist/:artist_id/event_search', to: 'consumer_events#search'
  get '/artist/event_search/event', to: 'consumer_events#show'

    resources :consumers do
      resources :reviews, only: [:new, :edit, :update ,:destroy]
      resources :consumers_events
    end

    resources :artists do
      resources :consumers_requests
      resources :reviews, only: [:create, :index ]
    end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
