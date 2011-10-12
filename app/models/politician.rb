class Politician < ActiveRecord::Base
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  def self.usernameidmatch
    Politician.find_in_batches(:batch_size => 100) do |array|
      users = Helpers.prepare_user_array(array)
      responseobj = Request.get(URL,{:user_id => users})
      response = JSON.parse(responseobj.body)
      response.each do |user|
        Politician.save_user(user)
      end
    end
  end
  
  def self.save_user(user)
    row = Politician.where(:user_id => user['id'])
    row[0].update_attributes(:screen_name => user['screen_name'])
  end
  
  def self.get_tweets_by_politicians
    counter = 0
    Politician.all.each do |politician|
      Resque.enqueue(GetPoliticiansTweets, politician.id)
      counter += 1
    end
    puts "#{counter} Jobs Queued Up"
  end
  
  def self.get_politicians_friends
    counter = 0
    Politician.all.each do |politician|
      Resque.enqueue(GetPoliticiansFriends, politician.id)
      counter += 1
    end
    puts "#{counter} Jobs Queued Up"
  end
end
