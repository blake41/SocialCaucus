class CreateCycleLogs < ActiveRecord::Migration
  def self.up
    create_table :cycle_logs do |t|
      t.string :process
      t.string :time
      t.integer :records_received
      t.integer :records_stored
      t.integer :page
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :cycle_logs
  end
end
