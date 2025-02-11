Rails.application.routes.draw do
  devise_for :users
  resources :orders, only: [:create, :show]
  resources :pizzas
  resources :inventories, only: [:index, :update]
  resources :crusts
  resources :sides
  resources :toppings

end
