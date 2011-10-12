class Changecolumnnameaveragenumtweetstoperday < ActiveRecord::Migration
  def self.up
    rename_column :stats, :average_number_of_tweets, :average_number_of_tweets_per_day
  end

  def self.down
    rename_column :stats, :average_number_of_tweets_per_day, :average_number_of_tweets
  end
end
