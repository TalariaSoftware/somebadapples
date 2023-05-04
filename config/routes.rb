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
  get '/post_records/:post_id', to: 'post_records#index', as: 'post_id'

  resources :lapd_headshots, only: %i[index show]
  namespace :us do
    namespace :ca do
      namespace :los_angeles do
        namespace :police do
          namespace :headshots20230321 do
            resources :headshots, only: %i[index show]
          end
          namespace :roster20220820 do
            resources :entries, only: %i[index show]
          end
        end
      end
    end
  end

  get '/search', to: 'search_results#index'

  devise_for :users

  mount Lookbook::Engine, at: '/lookbook'
  mount IronTeapot::Engine => '/'
end
