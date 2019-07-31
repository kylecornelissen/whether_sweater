Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      # GET /api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese
      get 'munchies', to: 'munchies#index'
      get 'users', to: 'users#create'
      post 'users', to: 'users#create'
    end
  end


end
