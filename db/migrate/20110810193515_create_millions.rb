class CreateMillions < ActiveRecord::Migration
  def self.up
    create_table :millions do |t|
      t.integer :user_id
      t.string :screen_name
      t.string :text
      t.integer :tweet_id
      t.date :timestamp
      t.integer :to_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :millions
  end
end
