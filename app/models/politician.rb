class Politician < ActiveRecord::Base
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  has_many :tweets, :class_name => "TweetsByPolitician"
  
  # database is not seeded with user_ids, must run this first before anything else
  def self.get_user_id_from_screen_name
    self.connection.select_values.("SELECT screen_name from politicians").find_in_batches(:batch_size => 100) do |array|
      screen_names = array.join(",")
      Resque.enqueue(GetScreenNamesFromUserIds, screen_names)
    end
  end
  
  def self.get_tweets_by_politicians
    counter = 0
    self.all.each do |politician|
      Resque.enqueue(GetPoliticiansTweets, politician.id)
      counter += 1
    end
    puts "#{counter} Jobs Queued Up"
  end

  def self.get_new_politicians_friends
    new_politicians = self.find_by_sql("SELECT a.user_id 
                                          FROM politicians p
                                          WHERE p.friends_count IS NULL 
                                          AND NOT exists
                                          (SELECT DISTINCT user_id 
                                          FROM politicians_friends pf 
                                          WHERE pf.politician_id = p.user_id)")
    new_politicians.each do |politician|
      Resque.enqueue(GetFriends, politician.user_id, self.class)
    end   
  end
  
  def self.get_new_politicians_followers
    new_politicians = self.find_by_sql("SELECT a.user_id 
                                          FROM politicians p 
                                          WHERE p.followers_count IS NULL 
                                          AND NOT exists
                                          (SELECT DISTINCT user_id 
                                          FROM politicians_followers pf 
                                          WHERE pf.politician_id = p.user_id)")
    new_politicians.each do |politician|
      Resque.enqueue(GetFollowers, politician.user_id, self.class)
    end   
  end

  def last_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).last.id : nil
  end

  def first_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).first.id : nil
  end

end
