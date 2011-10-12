class CreateTempMillions < ActiveRecord::Migration
  def self.up
    create_table :temp_millions do |t|
      t.string :raw_tweet

      t.timestamps
    end
  end

  def self.down
    drop_table :temp_millions
  end
end
