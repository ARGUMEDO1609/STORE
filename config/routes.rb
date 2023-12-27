Rails.application.routes.draw do
  resources :categories, except: :show
  root 'products#index'
  resources :products
end
