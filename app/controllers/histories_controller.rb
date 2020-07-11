class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    musicpost = Musicpost.find(params[:musicpost_id])
    current_user.history(musicpost)
  end
end
