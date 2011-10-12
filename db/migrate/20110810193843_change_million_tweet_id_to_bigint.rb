class ChangeMillionTweetIdToBigint < ActiveRecord::Migration
  def self.up
    change_column :millions, :tweet_id, :bigint
  end

  def self.down
    change_column :millions, :tweet_id, :integer
  end
end
