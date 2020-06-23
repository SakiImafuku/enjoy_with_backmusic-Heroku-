class CommentsController < ApplicationController
  def create
    musicpost = Musicpost.find(params[:musicpost_id])
    current_user.comment(musicpost, params[:content])
    redirect_back_or root_url
  end

  def destroy

  end
end
