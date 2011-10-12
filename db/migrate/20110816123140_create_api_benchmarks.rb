class CreateApiBenchmarks < ActiveRecord::Migration
  def self.up
    create_table :api_benchmarks do |t|
      t.string :screen_name
      t.string :text
      t.integer :tweet_id
      t.integer :user_id
      t.integer :to_user_id
      t.date :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :api_benchmarks
  end
end
