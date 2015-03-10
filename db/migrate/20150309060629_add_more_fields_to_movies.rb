class AddMoreFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :cached_rating_count, :integer
    add_column :movies, :cached_average_rating, :float
  end
end
