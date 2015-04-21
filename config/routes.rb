Rails.application.routes.draw do
  root 'static_pages#rootPage'

  resources :users do
    resources :tests do
        get 'active_test'
        post 'results'
      end
    resources :topics do
      resources :questions do
        resources :answers
      end
    end
  end

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

end
