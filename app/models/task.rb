class Task < ActiveRecord::Base
  
  def self.get_profiles
    Activist.get_profiles
  end
  
  def self.get_mentions 
    Activist.set_politicians
  end
  
  def self.get_friends
    Activist.get_friends
  end
  
  def self.add_new_activists
    Activist.add_new_activists
  end

  def self.start_cycle
    self.get_mentions
    self.get_friends
    self.get_profiles
  end

  def self.update_friends_count
    activists = Activist.find_by_sql("SELECT user_id, count(id) as friends_count FROM activist_friends GROUP BY user_id")
    activists.each do |activist|
      Activist.where(:user_id=>activist.user_id).update_all(:friends_count => activist.friends_count)
    end
  end

end
