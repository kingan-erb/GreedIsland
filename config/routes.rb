Rails.application.routes.draw do

  devise_for :administrators, controllers: {
    sessions:      'administrators/sessions',
    passwords:     'administrators/passwords',
    registrations: 'administrators/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  # get 'products/index',as:'products'
  # get 'products/show'
  # get 'products/new' => 'products#new', as:'new_product'
  # post 'products/new' => 'products#create'
  resources :products
  resources :musics
  resources :administrators
  resources :cart_items, :except => [:create,:edit]
  post '/product/:product_id/cart_items' => 'cart_items#create', as:'create_cart_item'
  get '/cart_items/edit' => 'cart_items#edit', as:'edit_cart_items'
  # post '/cart_items/:id/edit' => 'cart_items#edit', as: 'edit_cart_item'
  # get 'products/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'greeds/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
