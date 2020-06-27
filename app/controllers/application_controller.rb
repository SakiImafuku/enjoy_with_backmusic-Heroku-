class ApplicationController < ActionController::Base
  before_action :store_location
  before_action :set_search

  # 記憶したURL（もしくはデフォルト値）にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # ransackを使用して検索する
  def set_search
    @q = Musicpost.ransack(params[:q])
    @search_results = @q.result(distinct: true).includes(:user, :taxons, :comments, :memos)
  end
end
