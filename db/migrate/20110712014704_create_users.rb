class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :user_id
      t.string :full_name
      t.string :party
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
