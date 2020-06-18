Rails.application.routes.draw do
  root 'static_pages#home'
  get '/play', to: 'static_pages#play'
  devise_for :users
  resources :upload_musicposts, only: [:new, :create]
  resources :musicposts, only: [:destroy]
end
