class Changepolsfollowersname < ActiveRecord::Migration
  def self.up
    rename_table :politicians_followers, :politician_followers
  end

  def self.down
    rename_table :politician_followers, :politicians_followers
  end
  
end
