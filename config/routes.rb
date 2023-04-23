Rails.application.routes.draw do
  root 'pages#home'

  resources :documents, only: %i[new create edit update destroy]
  resources :incidents do
    resources :roles, only: %i[new create edit update destroy]
  end
  resources :officers, only: %i[show new edit create update destroy] do
    resources :positions, only: %i[new create edit update destroy]
  end
  resources :agencies do
    resources :officers, only: %i[index]
  end

  resources :post_records, only: %i[index]

  get '/search', to: 'search_results#index'

  devise_for :users

  mount Lookbook::Engine, at: '/lookbook'
  mount IronTeapot::Engine => '/'
end
