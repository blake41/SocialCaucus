class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :screen_name
      t.string :text
      t.integer :tweet_id
      t.string :keyword
      t.integer :retweet_count
      t.string :in_reply_to
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
