class StartTime
  
  @queue = :get_mentions
  
  def self.perform
    CycleLog.log_start_time
    CycleLog.log_start_count
  end
  
end