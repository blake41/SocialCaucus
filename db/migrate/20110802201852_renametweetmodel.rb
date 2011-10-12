class Renametweetmodel < ActiveRecord::Migration
  def self.up
    rename_table :tweets, :politicians_tweets_abouts
  end

  def self.down
    rename_table :politicians_tweets_abouts, :tweets
  end
end
