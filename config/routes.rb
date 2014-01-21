Sparta::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]
  resource :user

  namespace :teacher do
    resource :dashboard, only: [:show]
    resources :courses
  end

  get 'sign_out' => 'sessions#destroy', as: 'sign_out'
  get 'sign_in' => 'sessions#new', as: 'sign_in'
  get 'sign_up' => 'users#new', as: 'sign_up'
  post 'users' => 'users#create', as: :users
  root :to => 'users#new'
end
