class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.all
  end

  def settings
    @user = current_user
  end
end
