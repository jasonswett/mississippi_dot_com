Rails.application.routes.draw do
  resources :books
  resources :authors
  devise_for :users
  root 'authors#index'
end
