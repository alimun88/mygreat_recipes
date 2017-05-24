Rails.application.routes.draw do
  get '/login', to: 'sessions#new' 
  post '/login', to: 'sessions#create'
  delete '/logout', to: "sessions#destroy"

  root 'pages#home'
  get 'pages/home'
  get 'pages/about'
  
  resources :contacts
  resources :recipes do
    resources :comments, only: [:create]
  end
  resources :key_ingredients
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  
  mount ActionCable.server => '/cable'
  
  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
