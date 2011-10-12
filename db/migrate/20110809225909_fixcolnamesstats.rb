class Fixcolnamesstats < ActiveRecord::Migration
  def self.up
    rename_column :stats, :average_number_of_tweets_per_politicians, :average_number_of_tweets_per_politician
  end

  def self.down
    rename_column :stats, :average_number_of_tweets_per_politician, :average_number_of_tweets_per_politicians
  end
end
