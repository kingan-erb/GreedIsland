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

  resources :greeds
  resources :administrators
  resources :addresses, :except => [:create,:edit,:show]

#users
  #ユーザー
  resources :users
  get 'users/:id/addresses' => 'users#address_update'
  post 'users/:id/address/new' => 'addresses#create', as: 'create_address'
  get 'users/:id/password/new' => 'users#password_edit', as: 'edit_password'
  patch 'users/:id/password' => 'users#password_update'
  get 'service' => 'users#service', as:'service'
  get 'privacy' => 'users#privacy', as:'privacy'
  get 'contact' => 'users#contact', as:'contact'
  get 'payment' => "users#payment", as: "payment"
  #管理者
  get 'admin/users' => 'users#admin_index', as:'admin_users'
  get 'admin/users/:id/edit' => 'users#admin_edit', as:'admin_edit_user'
  get 'admin/users/:id' => 'users#admin_show', as:'admin_show_user'
  patch 'admin/users/:id' => 'users#admin_update'

#products
  #ユーザー
  get 'greeds/:id/products' => 'products#index', as:'products'
  get 'greeds/products/search' => 'products#search',as:'search_products'
  get 'greeds/products/:id' => 'products#show',as:'product'
  get 'greeds/:id/products/recommend' => 'products#recommend',as:'recommend_products'
  #管理者
  get 'admin/products' => 'products#admin_index', as: 'admin_products'
  get 'admin/greed/:id/products' => 'products#admin_category', as: 'admin_show_category'
  get 'admin/products/new' => 'products#admin_new', as: 'admin_new_product'
  post 'admin/products' => 'products#admin_create', as: 'admin_create_product'
  get 'admin/products/:id' => 'products#admin_show', as: 'admin_show_product'
  get 'admin/products/:id/edit' => 'products#admin_edit', as: 'admin_edit_product'
  patch 'admin/products/:id' => 'products#admin_update'
  delete 'admin/products/:id' => 'products#admin_destroy'
  post 'admin/products/:id/musics' => 'musics#create', as: 'admin_new_music'

#cart_items
  resources :cart_items, :except => [:create,:edit,:show]
  #cart_items#showが#editより上にあるとedit_cartに流れずshowに流れた。
  #resourcesの自動ルーティングに順序を合わせるのがベターっぽい
  # get '/cart_items' => 'cart_items#index', as:'cart_items'
  # get '/cart_items/buy' => 'cart_items#show', as:'buy_cart_items'
  post '/product/:product_id/cart_items' => 'cart_items#create', as:'create_cart_item'
  # post '/cart_items/:id/edit' => 'cart_items#edit', as: 'edit_cart_item'

#orders
  #ユーザー
  resources :users do
    resources :orders, only: [:show]
  end
  get 'buy_confirm' => 'orders#new', as:'new_order'
  get 'orders/:id' => 'orders#show', as:'show_order'
  get 'order/thanks/:id' => 'orders#thanks', as:'thanks_order'
  #管理者
  get 'admin/orders' => 'orders#admin_index', as:'admin_orders'
  post 'admin/orders' => 'orders#create' #adminの範疇ではないがurlをindexに合わせる
  # get 'users/:id/orders/:id' => 'orders#user_show', as: 'user_order_show'
  # get 'users/:id/orders/:id/edit' => 'orders#user_edit', as: 'user_order_edit'
  get 'admin/users/:user_id/orders/:id' => 'orders#admin_show', as: 'admin_show_order'
  patch 'admin/users/:user_id/orders/:id' => 'orders#admin_update', as: 'admin_update_order'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
