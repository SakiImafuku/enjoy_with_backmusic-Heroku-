class StaticPagesController < ApplicationController
  def home
    session[:order] = params[:order] || session[:order] || "latest_order"
    @order = session[:order]
    if @order  == "popular_order"
      @musicposts = Musicpost.popular.page(params[:page]).per(8).with_attached_audio.includes(:user, :favorites, :comments)
    else
      @musicposts = Musicpost.latest.page(params[:page]).per(8).with_attached_audio.includes(:user, :favorites, :comments)
    end
  end

  def settings
    @user = current_user
  end

  def search
    @musicposts = @search_results.with_attached_audio.includes(:user, :taxons)
    @search_word = params[:q][:title_or_overview_or_user_name_or_taxons_name_or_comments_content_or_memos_memo_cont]
  end
end
