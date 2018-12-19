Rails.application.routes.draw do
  root 'items#home'
  get 'addresses' => 'addresses#index'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'items'   => 'items#show'
  get 'cart_items' => 'cart_items#show'
  post 'cart_items' => 'cart_items#create'
  patch 'cart_items' => 'cart_items#update'
  get 'orders'   => 'orders#show'
  post 'orders'   => 'orders#create'
  get  'select_address' => 'select_addresses#show'
  patch 'select_address' => 'select_addresses#update'
  resources :users
  resources :addresses
  resources :items
  resources :cart_items
  resources :orders do
    collection do
      get :completed
    end
  end
end
