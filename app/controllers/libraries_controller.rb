class LibrariesController < ApplicationController
  def favorites
    @musicposts = current_user.fav_musicposts.latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
  end

  def following
    @musicposts = Musicpost.following_musicposts(current_user).latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
  end
end
