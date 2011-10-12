class Editcolumnintweetsandaddcorrectuserid < ActiveRecord::Migration
  def self.up
    add_column :tweets, :search_user_id, :integer
  end

  def self.down
    remove_column :tweets, :search_user_id
  end
end
