class Task
  
  # a follower is someone who follows me  
  # a friend is a person I follow.  The opposite of a follower
  
  def self.get_profiles
    # get the profile of the user
    Activist.get_profiles
  end
  
  def self.get_mentions
    #  ask twitter search api for all mentions of a politicans screen name
    # add a row to politicianstweetsabout for each tweet
    Activist.set_politicians
  end
  
  def self.get_friends
    # get all the "friends" of the activist.  
    Activist.get_friends
  end
  
  def self.add_new_activists
    # for each new user_id we have in the politicianstweetsabouts table add them to the activists table
    Activist.add_new_activists
  end

  def self.start_cycle
    self.get_mentions
    # get mentions does the following:
    # log our start time
    # look for new mentions of each politician
    # log our end time
    # add all new activists to the activists table
    # run it all again    
    self.get_friends
    # get the friends of all new activists
    self.get_profiles
    # get profile/demographic info for each new activist
  end

  def self.update_friends_count
    # cache how many friends an activist has
    activists = Activist.find_by_sql("SELECT user_id, count(id) as friends_count FROM activist_friends GROUP BY user_id")
    activists.each do |activist|
      Activist.where(:user_id=>activist.user_id).update_all(:friends_count => activist.friends_count)
    end
  end

end
