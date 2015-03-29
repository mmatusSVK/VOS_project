Rails.application.routes.draw do

  resources :users
  resources :topic
  root 'static_pages#rootPage'

 # get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
