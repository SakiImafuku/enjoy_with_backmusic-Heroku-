class MemosController < ApplicationController
  before_action :authenticate_user!

  def index
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家')
    @instrument = @musicpost.taxons_filter('演奏楽器')
    @memo = Memo.find_by(user_id: current_user.id, musicpost_id: @musicpost.id)
  end

  def create
    musicpost = Musicpost.find(params[:musicpost_id])
    current_user.memo(musicpost, params[:memo])
    redirect_back_or root_url
  end

  def edit
    @musicpost = Musicpost.find(params[:id])
    @composer = @musicpost.taxons_filter('作曲家')
    @instrument = @musicpost.taxons_filter('演奏楽器')
    @memo = Memo.find_by(user_id: current_user.id, musicpost_id: @musicpost.id)
  end

  def update
    musicpost = Musicpost.find(params[:musicpost_id])
    current_user.memo_update(musicpost, params[:memo][:memo])
    redirect_to memos_path
  end

  def destroy
    musicpost = Musicpost.find(params[:id])
    memo = Memo.find_by(user_id: current_user.id, musicpost_id: musicpost.id)
    memo.delete if current_user == memo.user
    redirect_back_or root_url
  end
end
