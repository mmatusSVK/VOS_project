Rails.application.routes.draw do
  root 'static_pages#rootPage'

  resources :users
  resources :topics

  namespace :admin do
    resources :articles, :comments
  end

 # get 'signup' => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
