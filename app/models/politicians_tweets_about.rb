class PoliticiansTweetsAbout < ActiveRecord::Base
  
  validates :tweet_id, :uniqueness => true

  belongs_to :activists

  def self.location
    PoliticiansTweetsAbout.joins("join activists a on a.user_id = politicians_tweets_abouts.activist_id")
  end
  
  def self.description
    PoliticiansTweetsAbout.joins("join activists a on a.user_id = politicians_tweets_abouts.activist_id")
  end

  def self.get_last_tweet_id(query)
    last_tweet_id = PoliticiansTweetsAbout.where(:keyword => query).minimum(:tweet_id)
    last_tweet_id.nil? ? "" : last_tweet_id
  end

end
