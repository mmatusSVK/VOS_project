Rails.application.routes.draw do
  root 'static_pages#rootPage'

  resources :users do
    resources :topics do
      resources :questions
    end
  end


 # get 'signup' => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
