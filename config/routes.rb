Rails.application.routes.draw do
  resources :customers
  resources :books
  resources :authors
  devise_for :users
  root 'authors#index'
end
