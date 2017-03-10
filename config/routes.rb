Rails.application.routes.draw do
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'search#index'

  get '/' => 'search#index'
  get '/result' => 'search#result'

  get '/signup', to: 'users#new' # match '/signup', to: 'users#new'
  
end
