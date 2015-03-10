# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150309060629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.integer "movielens_id"
    t.string  "title"
    t.text    "genres",                default: [], array: true
    t.string  "imdb_id"
    t.string  "poster_url"
    t.float   "imdb_rating"
    t.text    "imdb_tagline"
    t.string  "imdb_mpaa_rating"
    t.string  "imdb_url"
    t.integer "imdb_votes"
    t.integer "cached_rating_count"
    t.float   "cached_average_rating"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "movielens_user_id"
    t.integer  "movielens_movie_id"
    t.float    "rating"
    t.datetime "rated_at"
  end

end
