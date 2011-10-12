class CreatePoliticianTweetsBies < ActiveRecord::Migration
  def self.up
    create_table :tweets_by_politicians do |t|
      t.string :screen_name
      t.string :text
      t.integer :tweet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets_by_politicians
  end
end
