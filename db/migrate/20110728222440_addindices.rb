class Addindices < ActiveRecord::Migration
  def self.up
    add_index :tweets, :search_user_id
    add_index :tweets, :user_id
    add_index :tweets, :screen_name
    add_index :activists, :user_id
  end

  def self.down
    remove_index :tweets, :search_user_id
    remove_index :tweets, :user_id
    remove_index :tweets, :screen_name
    remove_index :activists, :user_id
  end
end
