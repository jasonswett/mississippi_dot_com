Rails.application.routes.draw do
  resources :authors
  devise_for :users
  root 'authors#index'
end
