class Keeptrackofifwehavealltweets < ActiveRecord::Migration
  def self.up
    add_column :politicians, :base_run_done, :integer
  end

  def self.down
    remove_column :politicians, :base_run_done
  end
end
