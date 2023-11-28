Rails.application.routes.draw do
  resources :genres
  resources :users

  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]

  get "signup" => "users#new"

end
