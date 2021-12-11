Rails.application.routes.draw do
  resources :officers
  devise_for :users

  root 'pages#home'
end
