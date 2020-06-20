Rails.application.routes.draw do
  root 'static_pages#home'
  get '/settings', to: 'static_pages#settings'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]
  resources :upload_musicposts, only: [:new, :create]
end
