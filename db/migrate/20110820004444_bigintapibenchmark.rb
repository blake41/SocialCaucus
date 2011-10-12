class Bigintapibenchmark < ActiveRecord::Migration
  def self.up
    change_column :api_benchmarks, :tweet_id, :bigint
  end

  def self.down
    change_column :api_benchmarks, :tweet_id, :integer
  end
end
