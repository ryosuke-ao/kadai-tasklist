Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :tofavs
      get :faveds
    end
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
 resources :tasks
 resources :favorites, only: [:create, :destroy]
end
