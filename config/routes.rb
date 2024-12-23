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
  resources :users do #/users/1/following, /users/1/followers
    member do
      get :following, :followers #GET	/users/1/following	action: following, routing :following_user_path(1)
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  #resolving an error that occures on some blowser "no route matches[GET]" 
  get '/microposts', to: 'static_pages#home'
end
