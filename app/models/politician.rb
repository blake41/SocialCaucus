class Politician < ActiveRecord::Base
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  def self.get_user_id_from_screen_name
    self.find_in_batches(:batch_size => 100) do |array|
      screen_names = array.collect(&:screen_name).join(",")
      responseobj = Request.get(URL,{:screen_name => screen_names})
      response = JSON.parse(responseobj.body)
      response.each do |user|
        self.save_user(user)
      end
    end
  end
  
  def self.save_user(user)
    row = Politician.where(:screen_name => user['screen_name'])
    row.first.update_attributes(:user_id => user['id'])
  end
  
  def self.get_tweets_by_politicians
    counter = 0
    self.all.each do |politician|
      Resque.enqueue(GetPoliticiansTweets, politician.id)
      counter += 1
    end
    puts "#{counter} Jobs Queued Up"
  end
  
  def self.get_politicians_friends
    counter = 0
    self.all.each do |politician|
      Resque.enqueue(GetPoliticiansFriends, politician.id)
      counter += 1
    end
    puts "#{counter} Jobs Queued Up"
  end
  
end
