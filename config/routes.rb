Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"
  post "/welcome", to: "welcome#create", as: :welcome
  get '/result', to: 'welcome#result', as: :result
  get "/dashboard", to: "users#show", as: :dashboard
  resources :tools, only: [:new]
  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  resources :tools, only: [:index, :show]

  resources :users, only: [:show]
end
