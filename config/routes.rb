Rails.application.routes.draw do
  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get    '/users/edit/password', to: 'users/registrations#edit_password',    as: :edit_user_registration_password
    patch  '/users/edit/password', to: 'users/registrations#password_update'    
  end
  resources :users, only: [:show]
  resources :upload_musicposts, only: [:new, :create]
end
