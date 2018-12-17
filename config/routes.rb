Rails.application.routes.draw do
  root               'items#home'
  get    'addresses' => 'addresses#index'
  get    'signup'  => 'users#new'
  patch  'edit_address' => 'users#edit_address'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get     'items'   => 'items#show'
  get     'cart_items' => 'cart_items#show'
  post    'cart_items' => 'cart_items#create'
  patch   'cart_items' => 'cart_items#update'
  get     'orders'   => 'orders#show'
  post    'orders'   => 'orders#create'
  get  'items/get_image'

  resources :users do
    member do
      get :select_address
    end
    collection do
      patch :update_address
    end
  end

  resources :addresses
  resources :items
  resources :cart_items

  resources :orders do
    collection do
      get :completed
    end
  end
end
