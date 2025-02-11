Rails.application.routes.draw do
  devise_for :users
  resources :orders, only: [:create, :show]
  resources :pizzas, only: [:index]
  resources :inventory, only: [:index, :update]
end
