class StaticPagesController < ApplicationController
  def home
    @musicposts = Musicpost.all
  end
end
