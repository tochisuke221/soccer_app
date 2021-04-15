Rails.application.routes.draw do
  
  root to: 'practices#index'
  devise_for :users
  resources :users,only: [:show,:edit,:update] 
  resources :practices

end
