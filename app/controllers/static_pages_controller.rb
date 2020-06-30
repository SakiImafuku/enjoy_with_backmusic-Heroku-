class StaticPagesController < ApplicationController
  def home
    order = params[:order]
    if order == "popular_order"
      @musicposts = Musicpost.popular.with_attached_audio.includes(:user, :taxons, :favorites).page(params[:page]).per(5)
    else
      @musicposts = Musicpost.latest.with_attached_audio.includes(:user, :taxons, :favorites).page(params[:page]).per(5)
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
