Rails.application.routes.draw do
  
  get 'practices/new'
  root to: 'pages#home'
  devise_for :users
  resources :users,only: [:show,:edit,:update] 


end
