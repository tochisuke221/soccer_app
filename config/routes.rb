Rails.application.routes.draw do
  
  
  root to: 'practices#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users,only: [:show,:edit,:update,:destroy] do
    resources :relationships,only:[:create,:destroy]
    resources :chat_rooms,only:[:index,:create,:show] do
      resources :chat_messages,only:[:create]
    end
  end
  resources :notifications,only: [:index] do
    collection do
      delete "destroy_all"
    end
  end
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
