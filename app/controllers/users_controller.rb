class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @musicposts = @user.musicposts.latest.page(params[:page]).per(8).
      with_attached_audio.includes(:favorites, :comments)
  end

  def favorites
    @user = User.find(params[:id])
    @musicposts = @user.fav_musicposts.latest.page(params[:page]).per(8).
      with_attached_audio.includes(:user, :favorites, :comments)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.with_attached_avatar
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.with_attached_avatar
  end

  def comments
    @user = User.find(params[:id])
    @comments = @user.comments.latest.page(params[:page]).per(20).includes(:musicpost)
  end
end
