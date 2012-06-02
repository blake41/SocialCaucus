class RemoveBaseRunAddFriendsAndFollowersToPoliticians < ActiveRecord::Migration
  def self.up
  	remove_column(:politicians, :base_run_done)
  	remove_column(:politicians, :search_base_run)
  	add_column(:politicians, :friends_count, :integer)
  	add_column(:politicians, :followers_count, :integer)
  end

  def self.down
  	add_column(:politicians, :base_run_done, :integer)
  	add_column(:politicians, :search_base_run, :integer)
  	remove_column(:politicians, :followers_count)
  	remove_column(:politicians, :friends_count)
  end
end
