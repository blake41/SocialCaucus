class CreateActivists < ActiveRecord::Migration
  def self.up
    create_table :activists do |t|
      t.string :user_id
      t.string :screen_name
      t.integer :follower_count
      t.string :description
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :activists
  end
end
