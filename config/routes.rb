Rails.application.routes.draw do
  devise_for :users
  root to: 'starts#new'
  resources :matchings, only: [:create, :destroy]
  resources :users do
    collection do
      get :profile_update
      get :confirm_request
    end
  end
  resources :starts
  resources :conversations do
    resources :messages
  end
end
