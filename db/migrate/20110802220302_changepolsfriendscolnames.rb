class Changepolsfriendscolnames < ActiveRecord::Migration
  def self.up
    rename_column :politicians_friends, :follower_id, :friend_id
  end

  def self.down
    rename_column :politicians_friends, :friend_id, :follower_id
  end
end
