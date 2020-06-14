class UploadMusicpostsController < ApplicationController
  def new
    @upload = UploadMusicpostForm.new
  end

  def create
    @upload = UploadMusicpostForm.new(set_params)

    # 作曲家、演奏楽器がDBにない場合登録
    @upload.composer_save unless Taxon.find_by(name: params[:composer])
    @upload.instrument_save unless Taxon.find_by(name: params[:instrument])

    # アップロード
    if @upload.save(current_user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def set_params
    params.permit(:title, :composer, :instrument, :overview, :audio)
  end
end
