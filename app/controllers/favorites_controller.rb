class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @musicpost = Musicpost.find(params[:musicpost_id])
    current_user.favorite(@musicpost)
    @musicpost.create_notification_like(current_user) unless current_user == @musicpost.user
    respond_to do |format|
      format.html { redirect_back_or root_url }
      format.js
    end
  end

  def destroy
    @musicpost = Favorite.find(params[:id]).musicpost
    current_user.unfavorite(@musicpost)
    respond_to do |format|
      format.html { redirect_back_or root_url }
      format.js
    end
  end
end
