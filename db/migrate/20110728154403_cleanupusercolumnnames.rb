class Cleanupusercolumnnames < ActiveRecord::Migration
  def self.up
    rename_column :users, :username, :screen_name
  end

  def self.down
    rename_column :users, :screen_name, :username
  end
end
