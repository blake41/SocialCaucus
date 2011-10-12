class Changebreakdowncolumnname < ActiveRecord::Migration
  def self.up
    rename_column :breakdowns, :type, :user_type
  end

  def self.down
    rename_column :breakdowns, :user_type, :type
  end
end
