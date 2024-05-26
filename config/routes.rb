Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'questions#index'
  resources :questions
  resources :answers
  # resources :password_resets, only: [:new, :create, :edit, :update]
  get "/password_reset/new", to: "password_resets#new"
  post "/password_reset/create", to: "password_resets#create"
  get "/password_reset/succes", to: "password_resets#succes", as: "succes"

  get '/new', to: 'questions#new'
  post '/create', to: 'questions#create'
  post 'answer/create', to: 'answers#create'

  get '/auth/github/callback', to: 'sessions#github_callback'
  get 'auth/github', to: 'sessions#github_auth'

  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  delete 'questions/destroy/:id', to: 'questions#destroy', as: 'destroy'
  delete 'answers/destroy_ans/:id', to: 'answers#destroy', as: 'destroy_ans'

  get "auth/login" => "auths#login", as: :login_path
  get '/auth/register', to: "auths#register", as: :register_path
  post '/auth/create', to: "auths#create"
  post 'auth/sign', to: "auths#sign"
  post 'auth/change_password', to: "auths#change_password"

  patch 'auths/update', to: 'auths#update', as: 'update_auths'

  get 'profile/show', to: "profiles#show"
  get 'profile/my_answers', to: "profiles#my_answers", as: :my_answers 
  get 'profile/my_questions', to: "profiles#my_questions", as: :my_questions
  get 'profile/settings', to: "profiles#settings"


  post '/uploads/create', to: "users#create_avatar_file"
  # Defines the root path route ("/")
  # root "posts#index"
end
