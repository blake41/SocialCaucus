class PoliticiansTweetsAbout < ActiveRecord::Base
  
  validates :tweet_id, :uniqueness => true

  def self.location
    PoliticiansTweetsAbout.joins("join activists a on a.user_id=politicians_tweets_abouts.user_id")
  end
  
  def self.description
    PoliticiansTweetsAbout.joins("join activists a on a.user_id=politicians_tweets_abouts.user_id")
  end
  
  def self.correct_search_id
    PoliticiansTweetsAbout.all.each do |tweet|
      PoliticiansTweetsAbout.store(tweet)
    end
  end
  
  def self.get_real_user_id
    PoliticiansTweetsAbout.where("user_id is null").find_in_batches(:batch_size => 100) do |array|
      Resque.enqueue(TweetCorrect, array)
    end
  end
  
  def self.store(tweet)
    user_id = tweet.user_id
    tweet.search_user_id = user_id
    tweet.user_id = 0
    tweet.save
  end
  
  def self.save_tweet(tweet, query)

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
