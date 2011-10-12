class GetFriendsStart
  
  @queue = :get_friends
  
  def self.perform
    Task.get_friends
  end
  
  
end