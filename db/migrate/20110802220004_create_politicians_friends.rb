class CreatePoliticiansFriends < ActiveRecord::Migration
  def self.up
    create_table :politicians_friends do |t|
      t.integer :politician_id
      t.integer :friend_id

      t.timestamps
    end
  end

  def self.down
    drop_table :politicians_friends
  end
end
