class PagesController < ApplicationController
  def home
    @top_movies = Movie.complete.order('cached_rating_count DESC').page(params[:page]).per(24)
  end
end
