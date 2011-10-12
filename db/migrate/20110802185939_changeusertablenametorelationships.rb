class Changeusertablenametorelationships < ActiveRecord::Migration
  def self.up
    rename_table :users, :politicians
  end

  def self.down
    rename_table :politicians, :users
  end
end
