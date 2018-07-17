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
  # #devise ログアウト用にURL上書き
  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   get "sign_out", :to => "users/sessions#destroy"
  # end
  # get 'products/index',as:'products'
  # get 'products/show'
  # get 'products/new' => 'products#new', as:'new_product'
  # post 'products/new' => 'products#create'
  resources :greeds
  resources :users
  resources :products
  resources :addresses, :except => [:create,:edit,:show]
  get 'greeds/:id/products' => 'products#user_index', as:'userside_products'
  get 'greeds/products/search' => 'products#user_search',as:'search_products'
  get 'greeds/products/:id' => 'products#user_show',as:'userside_product'
  resources :musics
  resources :administrators
  #cart_items#showが#editより上にあるとedit_cartに流れずshowに流れた。
  #resourcesの自動ルーティングに順序を合わせるのがベターっぽい
  # get '/cart_items' => 'cart_items#index', as:'cart_items'
  # get '/cart_items/buy' => 'cart_items#show', as:'buy_cart_items'
  resources :cart_items, :except => [:create,:edit,:show]
  post '/product/:product_id/cart_items' => 'cart_items#create', as:'create_cart_item'
  # post '/cart_items/:id/edit' => 'cart_items#edit', as: 'edit_cart_item'
  # get 'products/edit'
  post 'products/:id/musics' => 'musics#create', as: 'music_new'
  get 'greed/:id/products' => 'products#category', as: 'category'

  #order
  get 'admin/orders' => 'orders#index', as:'orders'
  #決済ページ
  get 'buy_confirm' => 'orders#new', as:'new_order'
  get 'admin/orders/:id/edit' => 'orders#edit', as:'edit_order'
  get 'orders/:id' => 'orders#show', as:'order'

  #admin/user
  get 'admin/users' => 'users#admin_index', as:'admin_user_index'
  get 'admin/user/:id/edit' => 'users#admin_edit', as:'edit_admin_user'
  get 'admin/user/:id' => 'users#admin_show', as:'admin_user'
  patch 'admin/user/:id' => 'users#admin_update'
  put 'admin/user/:id' => 'users#admin_update'
  post 'user/:id/address/new' => 'addresses#create', as: 'address_new'
  get 'users/:id/addresses' => 'users#address_update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
