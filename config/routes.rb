Rails.application.routes.draw do
  
  
  root to: 'practices#index'
  devise_for :users
  resources :users,only: [:show,:edit,:update] do
    resources :relationships,only:[:index,:create,:destroy]
  end
  resources :notifications,only: :index
  resources :practices do
    resources :likes, only: [:create, :destroy]
    resources :pcomments, only: [:create, :destroy]
    collection do
      get "rank"
      get "ptaglist"
      get "search"
    end
  end

end
