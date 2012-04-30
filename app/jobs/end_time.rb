class EndTime
  
  @queue = :get_mentions
  
  def self.perform
    CycleLog.log_end_count
    CycleLog.log_end_time
  end
  
end