class Activist < ActiveRecord::Base
  # scope :null, where(:user_id => nil)
  scope :not_null, where('user_id is not null')
  scope :anon, lambda {|column_name, search_for| where("#{column_name} like ?", "%"+search_for+"%")}
  # still want this? or use user_id
  validates :screen_name, :uniqueness => true 
  
  has_many :friends, :primary_key => :user_id, :class_name => "ActivistsFriend"
  has_many :followers, :primary_key => :user_id, :class_name => "ActivistsFollower"
  has_many :tweets, :primary_key => :user_id, :class_name => "PoliticiansTweetsAbout"

  def self.null
    self.connection.select_values("SELECT screen_name from activists where user_id IS NULL")
  end

  def self.search(q)
    [:location, :description].inject(scoped) do |combined_scope, attr|
      combined_scope.where("activists.#{attr} LIKE ?", "%#{q}%")
    end
  end
  
  def self.new_activists
    self.connection.select_values("SELECT DISTINCT p.activist_id FROM politicians_tweets_abouts p WHERE NOT EXISTS
                                  (SELECT *
                                  FROM activists a 
                                  WHERE p.activist_id = a.user_id)")
  end

  def self.without_friends
    self.find_by_sql("SELECT a.user_id FROM activists a WHERE a.friends_count IS NULL")
  end
  
  def self.without_followers
    self.find_by_sql("SELECT a.user_id FROM activists a WHERE a.followers_count IS NULL")
  end

  def self.get_new_followers
    self.without_followers.each do |activist|
      Resque.enqueue(GetFollowers, activist.user_id, self.name)
    end   
  end

  def self.add_new_activists
    Crewait.start_waiting
      self.new_activists.each do |activist_id|
        self.crewait(:user_id => activist_id)
      end
    Crewait.go!
  end

  def self.get_new_friends
    self.without_friends.each do |activist|
      Resque.enqueue(GetFriends, activist.user_id, self.name)
    end
  end

  def self.get_profiles
    null_array = self.null
    null_array.in_groups_of(100) do |chunk|
      followers = chunk.compact.join(",")
      Resque.enqueue(GetProfiles, followers)
    end
  end


end
