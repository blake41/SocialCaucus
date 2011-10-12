class Changebigintintemptable < ActiveRecord::Migration
  def self.up
    change_column :temp_tables, :tweet_id, :bigint
  end

  def self.down
    change_column :temp_tables, :tweet_id, :integer
  end
end
