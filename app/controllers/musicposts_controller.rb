class MusicpostsController < ApplicationController
  def show
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家').name
    @instrument = @musicpost.taxons_filter('演奏楽器').name
  end
end
