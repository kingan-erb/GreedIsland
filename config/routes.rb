Rails.application.routes.draw do
  get 'products/index', as:'products'
  get 'products/show'
  get 'products/new' => 'products#new', as:'new_product'
  post 'products/new' => 'products#create'
  post '/admin/musics/new' => 'musics#create'
  get 'products/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'greeds/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
