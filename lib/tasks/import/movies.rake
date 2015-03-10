require 'rainbow/ext/string'
require 'csv'
include ActionView::Helpers::NumberHelper
MOVIES_FILE = Rails.root.join('data', 'movies.dat')

namespace :import do
  desc 'Import movies into database'
  task movies: :environment do
    puts 'Deleting existing movies!'.color(:yellow)
    Movie.delete_all

    puts 'Starting import...'.color(:green)

    File.open(MOVIES_FILE, 'r').each_line do |line|
      puts "Reading line #{number_with_delimiter $INPUT_LINE_NUMBER}..."
      data = line.split('::')

      movie = Movie.new
      movie.movielens_id = data[0]
      movie.title = data[1]

      genres = data[2].split('|')
      movie.genres = genres

      if movie.save
        puts "Movie #{movie.id} saved!".color(:green)
      else
        puts "Movie failed to save! #{movie.errors.full_messages.join('; ')}".color(:red)
      end
    end
    puts 'Done!'.color(:green)
  end
end
