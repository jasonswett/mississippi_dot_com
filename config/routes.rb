Rails.application.routes.draw do
  resources :line_items
  resources :orders

  resources :orders_user_sessions, only: [:new, :create] do
    post 'check_user', on: :collection
  end

  resources :customers
  resources :books
  resources :authors
  devise_for :users
  root 'orders#index'
end
