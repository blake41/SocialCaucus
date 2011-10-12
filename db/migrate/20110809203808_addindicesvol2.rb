class Addindicesvol2 < ActiveRecord::Migration
  def self.up
    add_index :politicians_followers, :follower_id
    add_index :politicians_followers, :user_id
    add_index :politicians_friends, :user_id
    add_index :politicians, :user_id
    add_index :tweets_by_politicians, :user_id
  end

  def self.down
    remove_index :politicians_followers, :follower_id
    remove_index :politicians_followers, :user_id
    remove_index :politicians_friends, :user_id
    remove_index :politicians, :user_id
    remove_index :tweets_by_politicians, :user_id
  end
end
