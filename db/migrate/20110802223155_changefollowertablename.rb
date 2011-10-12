class Changefollowertablename < ActiveRecord::Migration
  def self.up
    rename_table :followers, :gillibrand_followers
  end

  def self.down
    rename_table :gillibrand_followers, :followers
  end
end
