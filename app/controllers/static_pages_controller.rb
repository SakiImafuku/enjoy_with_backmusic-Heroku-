class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.all
  end

  def play
    @select_musicpost = Musicpost.find(params[:select_musicpost_id])
    session[:select_musicpost_id] = @select_musicpost.id
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
