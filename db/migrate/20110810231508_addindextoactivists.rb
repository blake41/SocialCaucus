class Addindextoactivists < ActiveRecord::Migration
  def self.up
    add_index :activists, :screen_name
  end

  def self.down
    remove_index :activists, :screen_name
  end
end
