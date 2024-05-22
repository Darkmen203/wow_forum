Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'questions#index'
  resources :questions
  resources :answers

  get '/new', to: 'questions#new'
  post '/create', to: 'questions#create'
  post 'answer/create', to: 'answers#create'

  get '/auth/github/callback', to: 'sessions#github_callback'
  get 'auth/github', to: 'sessions#github_auth'

  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'



  get 'authform/login', to: "authforms#login"
  get 'authform/register', to: "authforms#register"
  get 'profile/show', to: "profiles#show"
  get 'profile/my_answers', to: "profiles#my_answers" 
  get 'profile/my_questions', to: "profiles#my_questions"
  get 'profile/settings', to: "profiles#settings"
  # Defines the root path route ("/")
  # root "posts#index"
end
