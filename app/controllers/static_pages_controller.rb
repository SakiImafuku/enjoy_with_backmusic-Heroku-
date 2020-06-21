class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.with_attached_audio.includes(:user, :taxons)
  end

  def settings
    @user = current_user
  end
end
