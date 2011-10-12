class Addcolumntopoliticianstweets < ActiveRecord::Migration
  def self.up
    add_column :tweets_by_politicians, :timestamp, :datetime
    
  end

  def self.down
    remove_column :tweets_by_politicians, :timestamp
  end
end
