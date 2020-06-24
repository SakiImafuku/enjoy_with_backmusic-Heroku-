class MusicpostsController < ApplicationController
  def show
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家')
    @instrument = @musicpost.taxons_filter('演奏楽器')
    @comments = @musicpost.comments.includes(user: :avatar_attachment).order(created_at: :desc)
  end
end
