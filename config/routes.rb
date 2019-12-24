Rails.application.routes.draw do
  devise_for :users
  root to: 'starts#new'

  resources :matchings, only: [:create, :destroy]
  resources :users do
    collection do
      get :profile_update
    end
  end
  resources :umbrellas
  resources :locations
  resources :starts do
    collection do
      get :miracle
    end
  end
  resources :conversations do
    resources :messages
  end
  
end
