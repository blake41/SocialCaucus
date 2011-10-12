class Addpoliticiantolog < ActiveRecord::Migration
  def self.up
    add_column :mylogs, :screen_name, :string
  end

  def self.down
    remove_column :mylogs, :screen_name
  end
end
