class Rating < ActiveRecord::Base

  belongs_to :movie, foreign_key: :movielens_id, primary_key: :movielens_movie_id
end
