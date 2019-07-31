Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'munchies', to: 'munchies#index'
      get 'users', to: 'users#create'
      post 'users', to: 'users#create'
      get "logout", to: "sessions#destroy"
      get "sessions", to: "sessions#create"
      post "sessions", to: "sessions#create"
      get "road_trip", to: "road_trip#create"
      post "road_trip", to: "road_trip#create"
    end
  end
end
