class CreateTableActivistFriend < ActiveRecord::Migration
  def self.up
    create_table :activist_friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :activist_friends
  end
end
