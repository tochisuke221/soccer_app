Rails.application.routes.draw do
  
  root to: 'pages#home'
<<<<<<< Updated upstream
  
=======
  devise_for :users
  resources :users,only: [:show,:edit,:update]
>>>>>>> Stashed changes
end
