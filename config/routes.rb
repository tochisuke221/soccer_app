Rails.application.routes.draw do
  
  root to: 'practices#index'
  devise_for :users
  resources :users,only: [:show,:edit,:update] 
  resources :practices do
    resources :likes, only: [:create, :destroy]
    resources :pcomments, only: [:create, :destroy]
    collection do
      get "rank"
    end
  end

end
