class Changetempmillionstolongtext < ActiveRecord::Migration
  def self.up
    change_column :temp_millions, :raw_tweet, :longtext
  end

  def self.down
    change_column :temp_millions, :raw_tweet, :string
  end
end
