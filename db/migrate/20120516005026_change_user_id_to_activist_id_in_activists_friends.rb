class ChangeUserIdToActivistIdInActivistsFriends < ActiveRecord::Migration
  def self.up
  	rename_column(:activists_friends, :user_id, :activist_id)
  end

  def self.down
  	rename_column(:activists_friends, :activist_id, :user_id)
  end
end
