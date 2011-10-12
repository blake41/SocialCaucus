class Addindextopolstweets < ActiveRecord::Migration
  def self.up
    add_index :politicians_tweets_abouts, :keyword
  end

  def self.down
    remove_index :politicians_tweets_abouts, :keyword
  end
end
