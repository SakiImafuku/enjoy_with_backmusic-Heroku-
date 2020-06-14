Rails.application.routes.draw do
  get 'musicposts/new'
  root 'static_pages#home'

  devise_for :users
  resources :upload_musicposts, only: [:new, :create]
end
