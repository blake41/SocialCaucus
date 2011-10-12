class Stat < ActiveRecord::Base
  
  @recipients = ['blake41@gmail.com',git 'suraj.patel1@gmail.com', 'ajishg@gmail.com']
  
  def self.create_stats
    Stat.create(:number_of_tweets => Stat.number_of_tweets, 
                :number_of_activists => Stat.number_of_activists,
                :number_of_activists_profiles => Stat.number_of_activists_profiles,
                :number_of_politicians_tracked => Stat.number_of_politicians_tracked,
                :number_of_keywords_tracked => Stat.number_of_keywords_tracked,
                :number_of_politicians_followers => Stat.number_of_politicians_followers,
                :number_of_activists_friends => Stat.number_of_activists_friends,
                :average_number_of_tweets_per_day => Stat.average_number_of_tweets_per_day,
                :average_number_of_tweets_per_keyword => Stat.average_number_of_tweets_per_keyword,
                :average_number_of_tweets_per_politician => Stat.average_number_of_tweets_per_politician
                )
    Stat.mail
  end
  
  def self.mail
    @recipients.each do |recipient|
      StatsMailer.send_stats(recipient).deliver
    end
  end
  
  def self.number_of_tweets
    PoliticiansTweetsAbout.count
  end
  
  def self.number_of_activists
    Activist.count
  end
  
  def self.number_of_activists_profiles
    Activist.not_null.count
  end
  
  def self.number_of_politicians_tracked
    Politician.count
  end
  
  def self.number_of_keywords_tracked
    0
  end
  
  def self.number_of_politicians_followers
    PoliticiansFollower.count(:follower_id, :distinct => true)
  end
  
  def self.number_of_activists_friends
    ActivistFriend.count(:friend_id, :distinct => true)
  end
  
  def self.average_number_of_tweets_per_day
    first_day = PoliticiansTweetsAbout.find_by_sql('select * from politicians_tweets_abouts order by timestamp asc limit 1')[0].timestamp
    last_day = Date.today
    number_of_days = (last_day - first_day).to_i
    average_tweets_per_day = PoliticiansTweetsAbout.count.to_f/number_of_days.to_f
  end
  
  def self.average_number_of_tweets_per_keyword
    0
  end
  
  def self.average_number_of_tweets_per_politician
    average_tweets_per_politician = PoliticiansTweetsAbout.count/Politician.count
  end
end
