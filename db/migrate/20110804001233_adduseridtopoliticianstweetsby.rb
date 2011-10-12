class Adduseridtopoliticianstweetsby < ActiveRecord::Migration
  def self.up
    add_column :tweets_by_politicians, :user_id, :integer
  end

  def self.down
    remove_column :tweets_by_politicians, :user_id
  end
end
