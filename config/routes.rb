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
  resources :greeds
  resources :products
  get 'greeds/:id/products' => 'products#user_index', as:'userside_products'
  get 'greeds/products/:id' => 'products#user_show',as:'userside_product'
  get 'greeds/products/search' => 'products#user_search_index',as:'search_products'
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
  post 'products/:id/musics' => 'musics#create', as: 'music_new'
  get 'greed/:id/products' => 'products#category', as: 'category'

  #order
  get 'admin/orders' => 'orders#index', as:'orders'
  get 'admin/orders/:id/edit' => 'orders#edit', as:'edit_order'
  get 'orders/:id' => 'orders#show', as:'order'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
