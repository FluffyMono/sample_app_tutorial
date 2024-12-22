Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get "/login", to: "sessions#new"
  #サーバーにデータを送信するのでpost
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  #resolving an error that occures on some blowser "no route matches[GET]" 
  get '/microposts', to: 'static_pages#home'
end
