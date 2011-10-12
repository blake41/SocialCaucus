class Changerelationshipstopoliticosfollowers < ActiveRecord::Migration
  def self.up
    rename_table :relationships, :politicians_followers
  end

  def self.down
    rename_table :politicians_followers, :relationships
  end
end
