class PoliticiansTweets < Job
  
  attr_accessor :url

  def initialize(user_id)
    self.politician ||= Politician.find_by_id(user_id)
    self.url = "/1/statuses/user_timeline.json"
  end

  def self.perform(user_id)
    self.new(user_id).perform
  end
  
end
