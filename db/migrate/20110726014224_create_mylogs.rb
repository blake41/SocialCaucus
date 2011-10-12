class CreateMylogs < ActiveRecord::Migration
  def self.up
    create_table :mylogs do |t|
      t.integer :error_code
      t.integer :page
      t.string :since_date
      t.string :until_date

      t.timestamps
    end
  end

  def self.down
    drop_table :mylogs
  end
end
