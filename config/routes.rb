Rails.application.routes.draw do
  root 'pages#home'

  resources :external_documents, only: %i[new create edit update destroy]
  resources :incidents do
    resources :incident_roles, only: %i[new create edit update destroy]
  end
  resources :officers

  get '/search', to: 'search_results#index'

  devise_for :users

  mount IronTeapot::Engine => '/'
end
