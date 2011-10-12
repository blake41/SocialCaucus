class Addsearchbaseruntopoliticians < ActiveRecord::Migration
  def self.up
    add_column :politicians, :search_base_run, :integer
  end

  def self.down
    remove_column :politicians, :search_base_run
  end
end
