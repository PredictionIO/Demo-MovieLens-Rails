class Movie < ActiveRecord::Base
  scope :complete, -> { where('poster_url IS NOT NULL') }
  has_many :ratings, primary_key: :movielens_id, foreign_key: :movielens_movie_id
end
