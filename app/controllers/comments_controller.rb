class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    musicpost = Musicpost.find(params[:musicpost_id])
    current_user.comment(musicpost, params[:content])
    redirect_back_or root_url
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.delete if current_user == comment.user
    redirect_back_or root_url
  end
end
