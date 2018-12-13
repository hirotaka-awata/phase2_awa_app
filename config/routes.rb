Rails.application.routes.draw do
  get 'addresses/new'
  get    'address' => 'addresses#index'
  get    'addresses/select' => 'addresses#select'
  root               'items#home'
  get    'signup'  => 'users#new'
  patch  'edit_address' => 'users#edit_address'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get     'items'   => 'items#show'
  get     'cart_items' => 'cart_items#show'
  post    'cart_items' => 'cart_items#create'
  patch   'cart_items' => 'cart_items#edit'
  get     'orders'   => 'orders#show'
  post    'orders'   => 'orders#create'
  get     'orders/completed' =>'orders#completed'
  get  'items/get_image'

  resources :users
  resources :addresses
  resources :items
  resources :cart_items
end
