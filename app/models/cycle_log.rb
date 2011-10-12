class CycleLog < ActiveRecord::Base
  
  def self.log_start_time
    Rails.logger.info "salsbury - start time - #{Time.now}"
  end
  
  def self.log_end_time
    Rails.logger.info "salsbury - end time - #{Time.now}"
  end
  
  def self.log_start_count
    Rails.logger.info "salsbury - start count - #{PoliticiansTweetsAbout.count}"  
  end
  
  def self.log_end_count
    Rails.logger.info "salsbury - end count #{PoliticiansTweetsAbout.count}"
  end
  
  def self.records_received(query,count)
    self.create(:process=>query, :records_received => count)
  end
  
  def self.records_stored(query,count)
    self.create(:process=>query, :records_stored => count)
  end
  
  def self.log_total_records_stored(query, total_stored)
    Rails.logger.info "salsbury - #{total_stored}"
  end
  
end
