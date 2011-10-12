class Fixtweetsids < ActiveRecord::Migration
  def self.up
    remove_column :tweets, :id
  end

  def self.down
    add_column :tweets, :id, :primary_key
  end
end
