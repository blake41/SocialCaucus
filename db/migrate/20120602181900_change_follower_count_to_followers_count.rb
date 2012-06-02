class ChangeFollowerCountToFollowersCount < ActiveRecord::Migration
  def self.up
  	rename_column(:activists, :follower_count, :followers_count)
  end

  def self.down
  	rename_column(:activists, :followers_count, :follower_count)
  end
end
