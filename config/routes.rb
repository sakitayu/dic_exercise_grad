Rails.application.routes.draw do
  devise_for :users,
              controllers: {registrations: "users/registrations"}
  unauthenticated do
    as :user do
      root :to => 'devise/registrations#new'
    end
  end
  resources :matchings, only: [:create, :destroy]
  resources :users do
    collection do
      # get :profile_update
      get :confirm_request
      get :start
    end
  end
  resources :tops, only: [:index]
  # resources :starts
  resources :conversations do
    resources :messages
  end
end
