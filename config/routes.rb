Rails.application.routes.draw do
  root 'static_pages#rootPage'

  resources :users do
    resources :topics
  end
  resources :questions

 # get 'signup' => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
