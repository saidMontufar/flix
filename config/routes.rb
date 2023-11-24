Rails.application.routes.draw do
  resources :users

  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]

  get "signup" => "users#new"

end
