class Changecolumnstweets < ActiveRecord::Migration
  def self.up
    remove_column :tweets, :retweet_count
    remove_column :tweets, :in_reply_to
    add_column :tweets, :user_id, :integer
    add_column :tweets, :to_user_id, :integer
    add_column :tweets, :timestamp, :date
  end

  def self.down
    add_column :tweets, :retweet_count, :integer
    add_column :tweets, :in_reply_to, :string
    remove_column :tweets, :user_id
    remove_column :tweets, :to_user_id
    remove_column :tweets, :timestamp
  end
end
