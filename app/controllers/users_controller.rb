class UsersController < ApplicationController
  before_action :authenticate_user!

  def favorites
    @user = User.find(params[:id])
    @musicposts = @user.fav_musicposts
  end

  def show
    @user = User.find(params[:id])
    @musicposts = @user.musicposts.with_attached_audio.includes(:taxons)
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
    @comments = @user.comments
  end

end
