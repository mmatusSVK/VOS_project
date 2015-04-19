Rails.application.routes.draw do
  root 'static_pages#rootPage'

  resources :users do
    resources :tests
    resources :current_tests
    resources :topics do
      resources :questions do
        resources :answers
      end
    end
  end


 # get 'signup' => 'users#new'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
