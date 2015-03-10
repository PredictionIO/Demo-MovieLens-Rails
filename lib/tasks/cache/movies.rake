require 'rainbow/ext/string'
namespace :cache do
  desc 'Update movie cache'
  task movies: :environment do
    success_count = 0
    failed_count = 0

    puts 'Starting cache calculations...'.color(:green)
    movie_count = Movie.all.count
    Movie.find_each.with_index do |movie, index|
      puts "Starting #{movie.title}... #{index + 1} of #{movie_count}"

      rating_count = movie.ratings.count
      puts "Rating Count: #{rating_count}"
      movie.cached_rating_count = rating_count

      average_rating = movie.ratings.average(:rating)
      puts "Average Rating: #{average_rating}"
      movie.cached_average_rating = average_rating

      if movie.save
        puts "Movie #{movie.title} saved!".color(:green)
        success_count += 1
      else
        error = "Movie ##{movie.id} #{movie.title} failed! #{e.errors.full_messages.join('; ')}".color(:red)
        RakeLogger.error error
        puts error.color(:red)
        failed_count = 0
      end
    end

    puts 'Done!'.color(:green)

    puts "Success: #{success_count}"
    puts "Failed: #{failed_count}"
  end
end
