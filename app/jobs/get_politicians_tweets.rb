class GetPoliticiansTweets < PoliticiansTweets

  @queue = :get_politicians_tweets

  attr_accessor :last_tweet_id

  def initialize(user_id)
    super
    self.last_tweet_id ||= self.politician.last_tweet_id
  end

  def options
    if self.last_tweet_id.nil?
      { :screen_name => self.politician.screen_name, :count => 200 }
    else
      { :screen_name => self.politician.screen_name, :count => 200, :max_id => self.last_tweet_id }
    end
  end


  def save_results(tweets)
    tweets.each do |tweet|
      TweetsByPolitician.crewait({:text => tweet['text'], 
                                :tweet_id => tweet['id'], 
                                :timestamp => tweet['created_at'],
                                :politician_id => self.politician.id} )
                                
    end
    puts "Completed Successfully - Stored #{tweets.count} Results"
    self.last_tweet_id = tweets.last['id'] - 1
  end

end