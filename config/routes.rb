Rails.application.routes.draw do
  root 'greeds#index'

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
  resources :users do
    resources :orders, only: [:show]
  end
  get 'admin/orders' => 'orders#index', as:'orders'
  post 'admin/orders' => 'orders#create' #adminの範疇ではないがurlをindexに合わせる
  # get 'users/:id/orders/:id' => 'orders#user_show', as: 'user_order_show'
  # get 'users/:id/orders/:id/edit' => 'orders#user_edit', as: 'user_order_edit'
  get 'admin/users/:user_id/orders/:id' => 'orders#admin_show', as: 'show_admin_order'
  get 'admin/users/:user_id/orders/:id/edit' => 'orders#admin_edit', as: 'edit_admin_order'
  patch 'admin/users/:user_id/orders/:id' => 'orders#admin_update', as: 'update_admin_order'
  #決済ページ
  get 'buy_confirm' => 'orders#new', as:'new_order'
  get 'admin/orders/:id/edit' => 'orders#edit', as:'edit_order'
  get 'orders/:id' => 'orders#show', as:'order'
  get 'order/thanks/:id' => 'orders#thanks', as:'thanks_order'

  #admin/user
  get 'admin/users' => 'users#admin_index', as:'admin_user_index'
  get 'admin/user/:id/edit' => 'users#admin_edit', as:'edit_admin_user'
  get 'admin/user/:id' => 'users#admin_show', as:'admin_user'
  patch 'admin/user/:id' => 'users#admin_update'
  put 'admin/user/:id' => 'users#admin_update'
  post 'users/:id/address/new' => 'addresses#create', as: 'address_new'
  get 'users/:id/addresses' => 'users#address_update'
  get 'users/:id/password/new' => 'users#password_edit', as: 'password_edit'
  patch 'users/:id/password' => 'users#password_update'
  get 'service' => 'users#service', as:'service'
  get 'privacy' => 'users#privacy', as:'privacy'
  get 'contact' => 'users#contact', as:'contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
