Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  resources :officers
  resources :incidents, only: %i[new create edit update destroy]
end
