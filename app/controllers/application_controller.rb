class ApplicationController < ActionController::Base
  before_action :select_music, expect: [:play, :create, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def select_music
    @select_musicpost = Musicpost.find_by(id: session[:select_musicpost_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
