class PoliticiansTweets < InfiniteJob

	attr_accessor :id_to_save

  def initialize(user_id)
    self.politician ||= Politician.find_by_id(user_id)
    self.url = "/1/statuses/user_timeline.json"
  end

  def self.perform(user_id)
    self.new(user_id).perform
  end
  
  def remove_unauthorized
    self.politician.destroy
  end

  def enqueue_myself
    Resque.enqueue(self.class, self.politician.user_id)
  end

  def save_results(tweets)
    tweets.each do |tweet|
      TweetsByPolitician.crewait({:text => tweet['text'], 
                                :tweet_id => tweet['id'], 
                                :timestamp => tweet['created_at'],
                                :politician_id => self.politician.id} )
                                
    end
    puts "Completed Successfully - Stored #{tweets.count} Results"
    self.last_tweet_id = self.id_to_save(tweets)
  end

end
