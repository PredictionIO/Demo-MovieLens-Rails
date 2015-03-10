require 'rainbow/ext/string'
require 'csv'
include ActionView::Helpers::NumberHelper
THREADS = 50
namespace :import do
  desc 'Send the data to PredictionIO'
  task predictionio: :environment do
    start_time = Time.current
    puts "Started at: #{start_time}".color(:blue)

    client = PredictionIO::EventClient.new(ENV['PIO_ACCESS_KEY'], ENV['PIO_EVENT_SERVER_URL'], THREADS)

    puts 'Starting import...'.color(:blue)

    puts 'Starting user import...'.color(:blue)
    unique_users = Rating.uniq.pluck(:movielens_user_id)
    user_count = unique_users.count
    unique_users.each_with_index do |user_id, index|
      client.acreate_event(
        '$set',
        'user',
        user_id
      )
      puts "Sent user ID #{user_id} to PredictionIO. Action #{number_with_delimiter index + 1} of #{number_with_delimiter user_count}"
    end


    puts 'Starting movie import...'.color(:blue)
    movie_count = Movie.all.count
    Movie.find_each.with_index do |movie, index|
      client.acreate_event(
        '$set',
        'item',
        movie.movielens_id,
        { 'properties' => { 'categories' => movie.genres } }
      )
      puts "Sent movie ID #{movie.id} to PredictionIO. Action #{number_with_delimiter index + 1} of #{number_with_delimiter movie_count}"
    end

puts 'Starting rating import...'.color(:blue)
rating_count = Rating.all.count
Rating.find_each.with_index do |rating, index|
  client.acreate_event(
    'rate',
    'user',
    rating.movielens_user_id, {
      'targetEntityType' => 'item',
      'targetEntityId' => rating.movielens_movie_id,
      'properties' => { 'rating' => rating.rating }
    }
  )
  puts "Sent rating ID #{rating.id} to PredictionIO. Action #{number_with_delimiter index + 1} of #{number_with_delimiter rating_count}"
end

    puts 'Done!'.color(:green)

    finish_time = Time.current
    total_time = finish_time - start_time
    puts "Finished at: #{finish_time}".color(:blue)
    puts "Total #{(total_time / 60).round(4)} minutes!".bright
  end
end
