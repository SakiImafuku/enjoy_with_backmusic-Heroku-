class UploadMusicpostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @upload_musicpost = UploadMusicpost.new
  end

  def create
    @upload_musicpost = UploadMusicpost.new(set_params)

    # 作曲家、演奏楽器がDBにない場合登録
    @upload_musicpost.composer_save unless Taxon.find_by(name: params[:composer])
    @upload_musicpost.instrument_save unless Taxon.find_by(name: params[:instrument])

    # アップロード
    if @upload_musicpost.save(current_user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def set_params
    params.require(:upload_musicpost).permit(:title, :composer, :instrument, :overview, :audio)
  end
end
