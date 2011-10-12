class Renameleaderidtouserid < ActiveRecord::Migration
  def self.up
    rename_column :politicians_followers, :leader_id, :user_id
  end

  def self.down
    rename_column :politicians_followers, :user_id, :leader_id
  end
end
