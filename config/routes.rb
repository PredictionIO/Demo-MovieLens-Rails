Rails.application.routes.draw do
  root 'pages#home'

  resources :movies, only: [:index, :show]
end
