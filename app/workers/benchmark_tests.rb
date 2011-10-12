class BenchmarkTests
  
  URL = 'http://twitter-blake41.apigee.com/search.json'
  
  
  def self.perform(query)
    date = Time.now
    until_date = date.to_date
    since_date = until_date-30.days
    responseobj = Request.get(URL,{:q => query,
                                    :rpp => 100, 
                                    :page => 1, 
                                    :since => since_date.to_s,
                                    :until => until_date.to_s})
                                    
    response = JSON.parse(responseobj.body)
    self.run_benchmarks(response, query)
  end
  
  def self.run_benchmarks(response,query)
    Activist.benchmark(message= "copenhagen - transaction wrapper") do
      self.transaction(response, query)
    end
    
    Activist.benchmark(message= "copenhagen - regular wrapper") do
      self.store(response, query)
    end
    
    Activist.benchmark(message= "copenhagen - crewait wrapper") do
        self.crewait_save(response, query)
    end
  end
  
  def self.store(response, query)
    response['results'].each do |tweet|
      PoliticiansTweetsAbout.create(:user_id => tweet['from_user_id'], 
                      :screen_name => tweet['from_user'], 
                      :text => tweet['text'],
                      :tweet_id => tweet['id'],
                      :to_user_id => tweet['to_user_id'],
                      :timestamp => tweet['created_at'],
                      :keyword => query)
    end
    puts "Completed Successfully - Stored #{response['results'].count} Results"
  end
  
  def self.transaction(response, query)
    PoliticiansTweetsAbout.transaction do
      response['results'].each do |tweet|
        PoliticiansTweetsAbout.create(:user_id => tweet['from_user_id'], 
                        :screen_name => tweet['from_user'], 
                        :text => tweet['text'],
                        :tweet_id => tweet['id'],
                        :to_user_id => tweet['to_user_id'],
                        :timestamp => tweet['created_at'],
                        :keyword => query)
      end
    end
  end
  
  def self.crewait_save(response, query)
    Crewait.start_waiting
      response['results'].each do |tweet|
        PoliticiansTweetsAbout.crewait(:user_id => tweet['from_user_id'], 
                        :screen_name => tweet['from_user'], 
                        :text => tweet['text'],
                        :tweet_id => tweet['id'],
                        :to_user_id => tweet['to_user_id'],
                        :timestamp => tweet['created_at'],
                        :keyword => query)
      end
      puts "Completed Successfully - Stored #{response['results'].count} Results"
    Crewait.go!
  end
end