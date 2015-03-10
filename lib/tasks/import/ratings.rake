require 'rainbow/ext/string'
require 'csv'
include ActionView::Helpers::NumberHelper
RATINGS_FILE = Rails.root.join('data', 'ratings.dat')

namespace :import do
  desc 'Import movies into database'
  task ratings: :environment do
    puts 'Deleting existing ratings!'.color(:yellow)
    Rating.delete_all

    puts 'Starting import...'.color(:green)

    File.open(RATINGS_FILE, 'r').each_line do |line|

      Thread.new{
        puts "Reading line #{number_with_delimiter $INPUT_LINE_NUMBER}..."
        data = line.split('::')

        rating = Rating.new
        rating.movielens_user_id = data[0]
        rating.movielens_movie_id = data[1]
        rating.rating = data[2]
        rating.rated_at = Time.at(data[3].to_i).to_datetime

        if rating.save
          puts "Rating #{rating.id} saved!".color(:green)
        else
          puts "Rating failed to save! #{rating.errors.full_messages.join('; ')}".color(:red)
        end
      }.join

    end
    puts 'Done!'.color(:green)
  end
end
