Rails.application.routes.draw do
  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    patch  '/users/edit/email', to: 'users/registrations#email_update'
    get    '/users/edit/password', to: 'users/registrations#edit_password', as: :edit_user_registration_password
    patch  '/users/edit/password', to: 'users/registrations#password_update'
  end
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  resources :upload_musicposts, only: [:new, :create]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:index, :create, :destroy]
  resources :musicposts, only: [:show]
end
