class ChangeUserIdAndScreenNameOnTweetsByPoliticians < ActiveRecord::Migration
  def self.up
  	rename_column(:tweets_by_politicians, :user_id, :politician_id)
  	remove_column(:tweets_by_politicians, :screen_name)
  end

  def self.down
  	add_column(:tweets_by_politicians, :screen_name)
  	rename_column(:tweets_by_politicians, :politician_id, :user_id)
  end
end
