require 'rainbow/ext/string'
require 'net/http'
include ActionView::Helpers::NumberHelper
namespace :import do
  desc 'IMDB stats'
  task imdb_stats: :environment do
    missing_poster_count = Movie.where('poster_url IS NULL').count

    puts "Missing Poster Count: #{number_with_delimiter missing_poster_count}"
  end

  desc 'Import movie fields into database'
  task imdb_fields: :environment do
    success_count = 0
    missing_count = 0
    failed_count = 0

    puts 'Starting IMDb calls...'.color(:green)
    movie_count = Movie.all.count
    Movie.find_each.with_index do |movie, index|
      puts "Starting #{movie.title}... #{number_with_delimiter index + 1} of #{number_with_delimiter movie_count}"

      m = Imdb::Movie.new(movie.imdb_id)

      if m
        puts "Updating IMDB ID #{movie.imdb_id}!"
        movie.imdb_rating = m.rating
        movie.poster_url = m.poster
        movie.imdb_tagline = m.tagline
        movie.imdb_mpaa_rating = m.mpaa_rating
        movie.imdb_url = m.url
        movie.imdb_votes = m.votes

        if movie.save
          puts "Movie #{movie.title} saved!".color(:green)
          success_count += 1
        else
          error = "Movie ##{movie.id} #{movie.title} failed! #{e.errors.full_messages.join('; ')}".color(:red)
          RakeLogger.error error
          puts error.color(:red)
          failed_count = 0
        end
      else
        error = "Movie ##{movie.id} #{movie.title} was not found!"
        RakeLogger.error error
        puts error.color(:red)
        missing_count += 1
      end
    end

    puts 'Done!'.color(:green)

    puts "Success: #{success_count}"
    puts "Missing: #{missing_count}"
    puts "Failed: #{failed_count}"
  end

  desc 'Import movies into database'
  task imdb_search: :environment do
    success_count = 0
    missing_count = 0
    failed_count = 0

    puts 'Starting IMDb calls...'.color(:green)
    movie_count = Movie.all.count
    Movie.find_each.with_index do |movie, index|
      puts "Starting #{movie.title}... #{number_with_delimiter index + 1} of #{number_with_delimiter movie_count}"

      i = Imdb::Search.new(movie.title)

      if i.movies.size > 0
        m = i.movies.first
        imdb_id = m.id

        puts "Adding IMDB ID #{imdb_id}!"
        movie.imdb_id = imdb_id
        movie.poster_url = m.poster

        if movie.save
          puts "Movie #{movie.title} saved!".color(:green)
          success_count += 1
        else
          error = "Movie ##{movie.id} #{movie.title} failed! #{e.errors.full_messages.join('; ')}".color(:red)
          RakeLogger.error error
          puts error.color(:red)
          failed_count = 0
        end
      else
        error = "Movie ##{movie.id} #{movie.title} was not found!"
        RakeLogger.error error
        puts error.color(:red)
        missing_count += 1
      end
    end

    puts 'Done!'.color(:green)

    puts "Success: #{success_count}"
    puts "Missing: #{missing_count}"
    puts "Failed: #{failed_count}"
  end
end
