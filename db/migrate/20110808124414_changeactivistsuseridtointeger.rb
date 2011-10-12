class Changeactivistsuseridtointeger < ActiveRecord::Migration
  def self.up
    change_table :activists do |t|
      t.change :user_id, :integer
    end
  end

  def self.down
    change_table :activists do |t|
      t.change :user_id, :string
    end
  end
end
