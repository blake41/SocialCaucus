class AddIndices < ActiveRecord::Migration
  def self.up
  	add_index(:politicians_tweets_abouts, :activist_id)
  end

  def self.down
  	remove_index(:politicians_tweets_abouts, :column => :activist_id)
  end
end
