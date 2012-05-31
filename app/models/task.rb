class Task
  
  # a follower is someone who follows me  
  # a friend is a person I follow.  The opposite of a follower
  
  def self.get_profiles
    # get the profile of the user
    Activist.get_profiles
  end
  
  def self.get_activists
    Politician.all.each do |politician|
      Resque.enqueue(GetActivists, politician.screen_name)
    end
  end
  
  def self.get_activists_friends
    # get all the "friends" of the activist.  
    Activist.get_friends
  end

  def self.get_activists_followers
    Activist.get_followers
  end
  
  def self.add_new_activists
    # for each new user_id we have in the politicianstweetsabouts table add them to the activists table
    Activist.add_new_activists
  end

  def self.get_politicians_tweets
    Politician.get_tweets_by_politicians
  end

  def self.get_new_politicians_followers
    Politician.get_new_politicians_followers
  end

  def self.get_new_politicians_friends
    Politician.get_new_politicians_friends
  end

end
