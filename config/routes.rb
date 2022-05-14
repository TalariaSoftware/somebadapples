Rails.application.routes.draw do
  root 'pages#home'

  resources :documents, only: %i[new create edit update destroy]
  resources :incidents do
    resources :roles, only: %i[new create edit update destroy]
  end
  resources :officers
  resources :agencies

  get '/search', to: 'search_results#index'

  devise_for :users

  mount IronTeapot::Engine => '/'
end
