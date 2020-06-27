class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.with_attached_audio.includes(:user, :taxons)
  end

  def settings
    @user = current_user
  end

  def search
    @musicposts = @search_results.with_attached_audio.includes(:user, :taxons)
    @search_word = params[:q][:title_or_overview_or_user_name_or_taxons_name_or_comments_content_or_memos_memo_cont]
  end
end
