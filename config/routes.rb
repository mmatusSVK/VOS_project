Rails.application.routes.draw do

  root 'static_pages#rootPage'

  get 'sessions/new'
  get 'signup' => 'users#new'
end
