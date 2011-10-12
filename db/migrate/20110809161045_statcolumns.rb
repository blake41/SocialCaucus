class Statcolumns < ActiveRecord::Migration
  def self.up
    add_column :stats, :number_of_tweets, :integer
    add_column :stats, :number_of_activists, :integer
    add_column :stats, :number_of_politicians_tracked, :integer
    add_column :stats, :number_of_keywords_tracked, :integer
    add_column :stats, :number_of_politicians_followers, :integer
    add_column :stats, :number_of_activists_friends, :integer
    add_column :stats, :average_number_of_tweets, :integer
    add_column :stats, :average_number_of_tweets_per_keyword, :integer
    add_column :stats, :average_number_of_tweets_per_politicians, :integer
  end

  def self.down
    remove_column :stats, :number_of_tweets, :integer
    remove_column :stats, :number_of_activists, :integer
    remove_column :stats, :number_of_politicians_tracked, :integer
    remove_column :stats, :number_of_keywords_tracked, :integer
    remove_column :stats, :number_of_politicians_followers, :integer
    remove_column :stats, :number_of_activists_friends, :integer
    remove_column :stats, :average_number_of_tweets, :integer
    remove_column :stats, :average_number_of_tweets_per_keyword, :integer
    remove_column :stats, :average_number_of_tweets_per_politicians, :integer
  end
end
