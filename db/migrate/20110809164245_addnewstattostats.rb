class Addnewstattostats < ActiveRecord::Migration
  def self.up
    add_column :stats, :number_of_activists_profiles, :integer
  end

  def self.down
    remove_column :stats, :number_of_activists_profiles
  end
end
