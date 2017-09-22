Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: "registrations"}
  # devise_for :users
  root to: 'pages#home'
  get '/search_results', to: 'artists#search'
  get '/search_results/artist', to: 'artists#show'

  get '/artists/:artist_id/eventsearch', to: 'artists#eventsearch', as: 'eventsearch'
  get '/consumers/:consumer_id/event/:id', to: 'consumers_events#show', as: 'event_details'
  post '/artists/:artist_id/artist_request', to: 'artist_requests#create', as: 'create_artist_request'
  patch '/artists/:artist_id/artist_request/accept/:id', to: 'artist_requests#accept', as: 'accept_artist_request'
  patch '/artists/:artist_id/artist_request/decline/:id', to: 'artist_requests#decline', as: 'decline_artist_request'

  post '/artist/:artist_id/reserveday', to: 'artist#reserve_day', as: 'reserve_day'

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
