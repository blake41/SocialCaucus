class Changeactiviststobigint < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.change :tweet_id, :bigint
    end
  end

  def self.down
    change_table :tweets do |t|
      t.change :tweet_id, :integer
    end
  end
end
