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
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'greeds/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
