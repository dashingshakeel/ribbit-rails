Rails.application.routes.draw do
  resources :relationships
  resources :ribbits
  get 'sessions/new'

  get 'sessions/create'
  get 'buddies', to: 'users#buddies', as: 'buddies'
  get 'sessions/destroy'
  post "sessions/create"

  resources :users 
  root 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
