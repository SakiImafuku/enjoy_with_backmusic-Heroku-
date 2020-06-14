class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.all
    @select_musicpost = Musicpost.find_by(id: params[:id])
  end

  def play
    @select_musicpost = Musicpost.find(params[:id])
    respond_to do |format|
      format.html { redirect_to root_url(id: @select_musicpost.id) }
      format.js
    end
  end
end
