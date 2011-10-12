class Apibenchmarkkeyword < ActiveRecord::Migration
  def self.up
    add_column :api_benchmarks, :keyword, :string
  end

  def self.down
    remove_column :api_benchmarks, :keyword
  end
end
