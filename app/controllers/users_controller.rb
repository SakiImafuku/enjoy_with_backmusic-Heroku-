class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @musicposts = @user.musicposts
  end

  def edit
  end  

  def update
  end
end
