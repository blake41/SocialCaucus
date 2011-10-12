class Changetweetidtobigint < ActiveRecord::Migration
  def self.up
    change_table :tweets_by_politicians do |t|
      t.change :tweet_id, :bigint
    end
  end

  def self.down
    change_table :tweets_by_politicians  do |t|
      t.change :tweet_id, :integer
    end
  end
end
