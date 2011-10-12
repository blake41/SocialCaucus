class Renamecolumnactivistsfriends < ActiveRecord::Migration
  def self.up
    rename_column :activist_friends, :user_id, :friend_id
    rename_column :activist_friends, :follower_id, :user_id
  end

  def self.down
    rename_column :activist_friends, :user_id, :follower_id
    rename_column :activist_friends, :friend_id, :user_id
  end
end
