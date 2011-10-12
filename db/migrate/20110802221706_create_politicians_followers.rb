class CreatePoliticiansFollowers < ActiveRecord::Migration
  def self.up
    create_table :politicians_followers do |t|
      t.integer :user_id
      t.integer :follower_id

      t.timestamps
    end
  end

  def self.down
    drop_table :politicians_followers
  end
end
