class Politician < ActiveRecord::Base
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  has_many :tweets, :class_name => "TweetsByPolitician"

  # database is not seeded with user_ids, must run this first before anything else
  def self.get_user_id_from_screen_name
    self.connection.select_values.("SELECT screen_name from politicians").find_in_batches(:batch_size => 100) do |array|
      screen_names = array.join(",")
      responseobj = Request.get(URL,{:screen_name => screen_names})
      response.each do |user|
        self.save_user(user)
      end
    end
  end
  
  def self.save_user(user)
    row = Politician.find_by_screen_name(:screen_name => user['screen_name'])
    row.update_attributes(:user_id => user['id'])
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
  
  def last_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).last.id : nil
  end

  def first_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).first.id : nil
  end

end
