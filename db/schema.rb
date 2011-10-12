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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110827200441) do

  create_table "activist_friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activist_friends", ["user_id"], :name => "index_relationships_on_follower_id"

  create_table "activists", :force => true do |t|
    t.integer  "user_id"
    t.string   "screen_name"
    t.integer  "follower_count"
    t.string   "description"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "not_authorized"
    t.integer  "friends_count"
  end

  add_index "activists", ["description"], :name => "fulltext_description"
  add_index "activists", ["location"], :name => "fulltext_location"
  add_index "activists", ["screen_name"], :name => "screen_name", :unique => true
  add_index "activists", ["user_id"], :name => "index_activists_on_user_id"

  create_table "api_benchmarks", :force => true do |t|
    t.string   "screen_name"
    t.string   "text"
    t.integer  "tweet_id",    :limit => 8
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.date     "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keyword"
  end

  create_table "cycle_logs", :force => true do |t|
    t.string   "process"
    t.string   "time"
    t.integer  "records_received"
    t.integer  "records_stored"
    t.integer  "page"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "millions", :force => true do |t|
    t.integer  "user_id"
    t.string   "screen_name"
    t.string   "text"
    t.integer  "tweet_id",    :limit => 8
    t.date     "timestamp"
    t.integer  "to_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mylogs", :force => true do |t|
    t.integer  "error_code"
    t.integer  "page"
    t.string   "since_date"
    t.string   "until_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screen_name"
  end

  create_table "politicians", :force => true do |t|
    t.integer  "user_id"
    t.string   "screen_name"
    t.string   "Full_Name"
    t.string   "Party"
    t.string   "State"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "base_run_done"
    t.integer  "search_base_run"
  end

  add_index "politicians", ["user_id"], :name => "index_politicians_on_user_id"

  create_table "politicians_followers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "politicians_followers", ["follower_id"], :name => "index_politicians_followers_on_follower_id"
  add_index "politicians_followers", ["user_id"], :name => "index_politicians_followers_on_user_id"

  create_table "politicians_friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "politicians_friends", ["user_id"], :name => "index_politicians_friends_on_user_id"

  create_table "politicians_tweets_abouts", :force => true do |t|
    t.string   "screen_name"
    t.string   "text"
    t.integer  "tweet_id",    :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.date     "timestamp"
    t.string   "keyword"
  end

  add_index "politicians_tweets_abouts", ["keyword"], :name => "index_politicians_tweets_abouts_on_keyword"
  add_index "politicians_tweets_abouts", ["screen_name"], :name => "index_tweets_on_screen_name"
  add_index "politicians_tweets_abouts", ["tweet_id"], :name => "tweet_id", :unique => true
  add_index "politicians_tweets_abouts", ["user_id"], :name => "index_tweets_on_user_id"

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_tweets"
    t.integer  "number_of_activists"
    t.integer  "number_of_politicians_tracked"
    t.integer  "number_of_keywords_tracked"
    t.integer  "number_of_politicians_followers"
    t.integer  "number_of_activists_friends"
    t.integer  "average_number_of_tweets_per_day"
    t.integer  "average_number_of_tweets_per_keyword"
    t.integer  "average_number_of_tweets_per_politician"
    t.integer  "number_of_activists_profiles"
  end

  create_table "tasks", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp_millions", :force => true do |t|
    t.text     "raw_tweet",  :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temp_tables", :force => true do |t|
    t.string   "screen_name"
    t.string   "text"
    t.integer  "tweet_id",    :limit => 8
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.date     "timestamp"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets_by_politicians", :force => true do |t|
    t.string   "screen_name"
    t.string   "text"
    t.integer  "tweet_id",    :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "timestamp"
    t.integer  "user_id"
  end

  add_index "tweets_by_politicians", ["user_id"], :name => "index_tweets_by_politicians_on_user_id"

end
