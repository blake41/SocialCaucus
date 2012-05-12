class RemoveScreenNameFromPoliticiansTweetsAboutAndChangeUserIdToActivistId < ActiveRecord::Migration
  def self.up
  	rename_column(:politicians_tweets_abouts, :user_id, :activist_id)
  	remove_column(:politicians_tweets_abouts, :screen_name)
  end

  def self.down
  	rename_column(:politicians_tweets_abouts, :activist_id, :user_id)
  	add_column(:politicians_tweets_abouts, :screen_name)
  end
end
