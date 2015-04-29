Rails.application.routes.draw do

  root 'static_pages#rootPage'

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]

  resources :users, only: [:show, :analyzed_tests] do
    get 'analyzed_tests'
    resources :tests do
        get 'concrete_test'
        get 'active_test'
        post 'results'
        get 'make_test_active'
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
