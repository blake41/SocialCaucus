class Addmonitoringcolumnstoactivists < ActiveRecord::Migration
  def self.up
    add_column :activists, :not_authorized, :integer
    add_column :activists, :friends_count, :integer
  end

  def self.down
    remove_column :activists, :not_authorized
    remove_column :activists, :friends_count
  end
end
