class AddCachedFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_tagline, :text
    add_column :movies, :imdb_mpaa_rating, :string
    add_column :movies, :imdb_url, :string
    add_column :movies, :imdb_votes, :integer

  end
end
