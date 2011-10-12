class Polfollowersissupposedtobeactivistsfriends < ActiveRecord::Migration
  def self.up
    rename_table :politician_followers, :activist_friends
  end

  def self.down
    rename_table :activists_friends, :politician_followers
  end
end
