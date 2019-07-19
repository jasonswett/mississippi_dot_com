Rails.application.routes.draw do
  resources :line_items
  resources :orders

  resources :orders_user_sessions, only: [:new, :create] do
    post 'check_user', on: :collection
  end

  resources :customers
  devise_for :users

  namespace :admin do
    resources :books
    resources :authors
  end

  root 'orders#index'
end
