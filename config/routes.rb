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
  resources :products, :except => [:index]
  get 'greeds/:greed_id/products' => 'products#index', as:'greed_products'
  resources :musics
  resources :administrators
  # get 'products/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get '/greeds' => 'greeds#index', as:'greeds'
  post 'products/:id/musics' => 'musics#create', as: 'music_new'

  #order
  get 'admin/orders' => 'orders#index', as:'orders'
  get 'admin/orders/:id/edit' => 'orders#edit', as:'edit_order'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
