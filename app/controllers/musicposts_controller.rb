class MusicpostsController < ApplicationController
  def show
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家')
    @instrument = @musicpost.taxons_filter('演奏楽器')
    @comments = @musicpost.comments.includes(user: :avatar_attachment).order(created_at: :desc)
  end

  def destroy
    musicpost = Musicpost.find(params[:id])
    musicpost.destroy
    flash[:success] = "投稿を削除しました"
    if session[:forwarding_url] == musicpost_url(musicpost)
      redirect_to root_url
    else
      redirect_back_or root_url
    end
  end
end
