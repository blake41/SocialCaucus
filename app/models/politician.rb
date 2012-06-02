class Politician < ActiveRecord::Base
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  has_many :tweets, :class_name => "TweetsByPolitician", :primary_key => :user_id
  has_many :friends, :class_name => "PoliticiansFriend", :primary_key => :user_id
  has_many :followers, :class_name => "PoliticiansFollower", :primary_key => :user_id


  def self.get_screen_names
    self.connection.select_values("SELECT screen_name from politicians")
  end

  def self.without_followers
    self.find_by_sql("SELECT p.user_id FROM politicians p WHERE p.followers_count IS NULL")
  end

  def self.without_friends
      self.find_by_sql("SELECT p.user_id FROM politicians p WHERE p.friends_count IS NULL")
  end

  # database is not seeded with user_ids, must run this first before anything else
  def self.get_user_id_from_screen_name
    self.get_screen_names.in_groups_of(100) do |chunk|
      screen_names = chunk.compact.join(",")
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

  def self.get_new_friends
    self.without_friends.each do |politician|
      Resque.enqueue(GetFriends, politician.user_id, self.name)
    end   
  end
  
  def self.get_new_followers
    self.without_followers.each do |politician|
      Resque.enqueue(GetFollowers, politician.user_id, self.name)
    end   
  end

  def last_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).last.tweet_id : nil
  end

  def first_tweet_id
    self.tweets.present? ? self.tweets.sort_by(&:tweet_id).first.tweet_id : nil
  end

end
