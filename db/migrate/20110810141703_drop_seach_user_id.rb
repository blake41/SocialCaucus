class DropSeachUserId < ActiveRecord::Migration
  def self.up
    remove_column :politicians_tweets_abouts, :search_user_id
  end

  def self.down
    add_column :politicians_tweets_abouts, :search_user_id, :integer
  end
end
