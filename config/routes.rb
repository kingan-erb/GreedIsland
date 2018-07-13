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
  post '/admin/musics/new' => 'musics#create'
  get '/admin/products/:product_id/musics/new' => 'musics#new', as:'admin_new_music'
  # get 'products/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'greeds/index'
  resources :administrators, only: [:create, :index, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
