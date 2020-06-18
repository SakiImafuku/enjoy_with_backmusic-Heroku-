Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users
  resources :upload_musicposts, only: [:new, :create]
end
