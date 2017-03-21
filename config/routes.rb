Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :advertisements
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'search#index'

  get '/' => 'search#index'
  get '/result' => 'search#result'

  get '/signup', to: 'users#new' # match '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  get '/advertisement/free', to: 'advertisements#free'
  get '/advertisement/add_free_book', to: 'advertisements#add_free_book'
end
