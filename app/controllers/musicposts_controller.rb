class MusicpostsController < ApplicationController
  def show
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家')
    @instrument = @musicpost.taxons_filter('演奏楽器')
    @comments = @musicpost.comments.includes(user: :avatar_attachment).order(created_at: :desc)
  end

  def destroy
    Musicpost.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました"
    if request.referrer == musicpost_path
      redirect_to root_url
    else
      redirect_to request.referrer || root_url
    end
  end
end
