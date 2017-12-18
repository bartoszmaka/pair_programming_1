Rails.application.routes.draw do
  devise_for :users

  resources :genres, only: %i[index show]
  resources :movies, only: %i[index show]

  namespace :admin do
    resources :genres, only: %i[create update destroy edit new]
    resources :movies, only: %i[create update destroy edit new]
  end

  root to: 'movies#index'
end
