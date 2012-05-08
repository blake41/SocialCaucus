class PoliticiansTweetsAbout < ActiveRecord::Base
  
  validates :tweet_id, :uniqueness => true

  def self.null
    PoliticiansTweetsAbout.connection.select_all("SELECT screen_name from politicians_tweets_abouts where user_id is null")
  end

  def self.location
    PoliticiansTweetsAbout.joins("join activists a on a.user_id=politicians_tweets_abouts.user_id")
  end
  
  def self.description
    PoliticiansTweetsAbout.joins("join activists a on a.user_id=politicians_tweets_abouts.user_id")
  end

  def self.get_highest_id(query)
    max_tweet_id = PoliticiansTweetsAbout.where(:keyword => query).maximum(:tweet_id)
    if max_tweet_id.nil?
      return ''    
    else
      max_tweet_id
    end
  end

end
