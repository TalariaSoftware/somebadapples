Rails.application.routes.draw do
  root 'pages#home'

  resources :officers
  resources :incidents, only: %i[new create edit update destroy]
  resources :external_documents, only: %i[new create edit update destroy]

  devise_for :users
end
