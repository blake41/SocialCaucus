class Activist < ActiveRecord::Base
  scope :null, where(:user_id => nil)
  scope :not_null, where('user_id is not null')
  scope :anon, lambda {|column_name, search_for| where("#{column_name} like ?", "%"+search_for+"%")}
  validates :screen_name, :uniqueness => true 
  
  def self.search(q)
    [:location, :description].inject(scoped) do |combined_scope, attr|
      combined_scope.where("activists.#{attr} LIKE ?", "%#{q}%")
    end
  end
  
  def self.set_politicians
    # log our start time
    # look for new mentions of each politician
    # log our end time
    # add all new activists to the activists table
    # run it all again
    Resque.enqueue(StartTime)       
    Politician.all.each do |politician|
      Activist.get_activists(politician.screen_name)
    end
    Resque.enqueue(EndTime)
    Resque.enqueue(NewTasks)
  end
  
  def self.get_activists(politician)
    today = Date.today
    Resque.enqueue(GetActivists, today, politician)
  end
  
  def self.add_new_activists
    new_activists= Activist.find_by_sql("SELECT DISTINCT p.screen_name FROM politicians_tweets_abouts p WHERE NOT EXISTS
    (SELECT *
    FROM activists a 
    WHERE p.screen_name = a.screen_name)")
    Crewait.start_waiting
      new_activists.each do |activist|
        Activist.crewait(:screen_name => activist.screen_name)
      end
    Crewait.go!
    puts new_activists.count
  end
  
  def self.get_friends
    new_activists = Activist.find_by_sql("SELECT a.screen_name, a.user_id 
                                          FROM activists a WHERE a.friends_count IS NULL 
                                          AND a.not_authorized IS NULL and  NOT exists
                                          (SELECT DISTINCT user_id 
                                          FROM activist_friends af 
                                          WHERE af.user_id = a.user_id)")
    new_activists.each do |activist|
      Resque.enqueue(GetFriends, activist.screen_name, activist.user_id)
    end
    Resque.enqueue(GetFriendsStart)
  end
  
  def self.get_profiles
    Activist.null.find_in_batches(:batch_size => 100) do |array|
      followers = Helpers.prepare_array(array)
      Resque.enqueue(GetProfiles, followers)
    end  
    Resque.enqueue(GetProfilesStart)
  end


end
