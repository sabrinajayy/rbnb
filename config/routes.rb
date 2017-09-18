Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: "registrations"}
  # devise_for :users
  root to: 'pages#home'
  get '/search_results', to: 'artists#search'
  get '/search_results/artist', to: 'artists#show'
  # get '/new_review" => 'project#new_release', :as => :new_release

    resources :consumers do
      resources :reviews, only: [:new, :edit, :update ,:destroy]
    end

    resources :consumer_events do
      resources :artist_requests, only: [:create]
    end

    resources :artists do
      resources :consumers_requests
      resources :reviews, only: [:create, :index ]
    end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
