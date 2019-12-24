Rails.application.routes.draw do
  devise_for :users
  root to: 'starts#new'
  #get 'confirm_requests', to: 'users#confirm_requests'
  resources :matchings, only: [:create, :destroy]
  resources :users do
    collection do
      get :profile_update
      get :confirm_request
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
