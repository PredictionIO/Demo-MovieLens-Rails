class MoviesController < ApplicationController
  def index
    @movies = Movie.complete.order('cached_rating_count DESC').page(params[:page])
  end

  def show
    @movie = Movie.find(params[:id])

    # Create PredictionIO client.
    client = PredictionIO::EngineClient.new(ENV['PIO_ENGINE_URL'])

    # Query PredictionIO.
    response = client.send_query(items: [@movie.movielens_id], num: 6)
    @recomendations = []

    # Loop though recomendations.
    response['itemScores'].each do |item|
      @recomendations << Movie.where(movielens_id: item['item']).take
    end
  end
end
