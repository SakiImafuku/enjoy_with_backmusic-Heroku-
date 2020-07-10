Rails.application.routes.draw do
  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings'
  get '/search', to: 'static_pages#search'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    patch  '/users/edit/email', to: 'users/registrations#email_update'
    get    '/users/edit/password', to: 'users/registrations#edit_password', as: :edit_user_registration_password
    patch  '/users/edit/password', to: 'users/registrations#password_update'
  end
  resources :users, only: [:show] do
    member do
      get :favorites, :following, :followers, :comments
    end
  end
  resources :upload_musicposts, only: [:new, :create]
  resources :relationships, only: [:create, :destroy]
  resources :libraries, only: [] do
    member do
      get :favorites, :following
    end
  end
  resources :favorites, only: [:create, :destroy]
  resources :musicposts, only: [:show, :destroy] do
    member do
      resources :memos, only: [:index, :create, :edit, :update, :destroy]
    end
  end
  resources :comments, only: [:create, :destroy]
  resources :histories, only: [:create]
end
