class NewTasks
  
  @queue = :get_mentions
  
  def self.perform
    Task.add_new_activists
    Task.get_mentions
  end
  
end