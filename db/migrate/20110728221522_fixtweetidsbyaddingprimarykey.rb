class Fixtweetidsbyaddingprimarykey < ActiveRecord::Migration
  def self.up
    add_column :tweets, :id, :primary_key
  end

  def self.down
    remove_column :tweets, :id
  end
end
