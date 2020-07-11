class LibrariesController < ApplicationController
  before_action :authenticate_user!

  def favorites
    @musicposts = current_user.fav_musicposts.latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
  end

  def following
    @musicposts = Musicpost.following_musicposts(current_user).latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
  end

  def histories
    @musicposts = Musicpost.history_musicposts(current_user).history_latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
    # @musicposts = current_user.history_musicposts.latest.page(params[:page]).per(8).
    #   with_attached_audio.includes(:user, :favorites, :comments)
  end
end
