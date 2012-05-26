class CreateTableActivistFriend < ActiveRecord::Migration
  def self.up
    create_table :activists_friends do |t|
      t.integer :activist_id
      t.integer :friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :activists_friends
  end
end
