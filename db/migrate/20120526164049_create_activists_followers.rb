class CreateActivistsFollowers < ActiveRecord::Migration
  def self.up
  	create_table :activists_followers do |t|
  		t.integer :activist_id
  		t.integer :follower_id
  		t.timestamps
  	end
  end

  def self.down
  	drop_table :activists_followers
  end
end
