class Activist < ActiveRecord::Base
  # scope :null, where(:user_id => nil)
  scope :not_null, where('user_id is not null')
  scope :anon, lambda {|column_name, search_for| where("#{column_name} like ?", "%"+search_for+"%")}
  validates :screen_name, :uniqueness => true 
  
  has_many :activists_friends

  def self.null
    self.connection.select_values("SELECT screen_name from activists where user_id IS NULL")
  end

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
      Resque.enqueue(GetActivists, politician.screen_name)
    end
    Resque.enqueue(EndTime)
    Resque.enqueue(NewTasks)
  end
  
  def self.new_activists
    self.connection.select_values("SELECT DISTINCT p.activist_id FROM politicians_tweets_abouts p WHERE NOT EXISTS
      (SELECT *
      FROM activists a 
      WHERE p.activist_id = a.user_id)")
  end

  def self.add_new_activists
    temp_new_activists = self.new_activists
    Crewait.start_waiting
      temp_new_activists.each do |activist_id|
        self.crewait(:user_id => activist_id)
      end
    Crewait.go!
    puts "#{temp_new_activists.count} activists added"
  end
  
  def self.get_friends
    new_activists = self.find_by_sql("SELECT a.user_id 
                                          FROM activists a 
                                          WHERE a.friends_count IS NULL 
                                          AND NOT exists
                                          (SELECT DISTINCT user_id 
                                          FROM activists_friends af 
                                          WHERE af.activist_id = a.user_id)")
    new_activists.each do |activist|
      Resque.enqueue(GetFriends, activist.user_id, self.class)
    end
    # Resque.enqueue(GetFriendsStart)
  end
  
  def tweets
    self.find_by_sql("SELECT * from politicians_tweets_abouts p where p.activist_id = #{self.user_id}")
  end

# left off here

  def self.get_profiles
    null_array = self.null
    null_array.in_groups_of(100) do |chunk|
      followers = chunk.join(",")
      Resque.enqueue(GetProfiles, followers)
    end
    Resque.enqueue(GetProfilesStart)
  end


end
