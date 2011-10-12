class Addkeywordstotweetsabouttable < ActiveRecord::Migration
  def self.up
    add_column :politicians_tweets_abouts, :keyword, :string
  end

  def self.down
    remove_column :politicians_tweets_abouts, :keyword
  end
end
