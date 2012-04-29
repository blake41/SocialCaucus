class GetPoliticiansTweets
  
  @queue = :Politicians_tweets
  
  URL = "/1/statuses/user_timeline.json"

  attr_accessor :screen_name
  attr_accessor :user_id
  attr_accessor :last_tweet_id
  attr_accessor :politician

  def initialize(user_id)
    self.politician ||= Politician.find(user_id)
    self.last_tweet_id ||= self.politician.last_tweet_id
  end

  def self.perform(user_id)
    self.new(user_id).perform
  end
  
  def perform
    # Crewait.start_waiting
    # start_page.upto(10000) do |page|
    #   # if self.base_run_done?(screen_name)
    #     # tweets = TweetsByPolitician.where(:screen_name => screen_name).order("tweet_id DESC")
    #   responseobj = self.get_tweets                               
    #   if Request.error_check(responseobj, page, self.politician.screen_name)
    #     puts "Error Code #{responseobj.code} on page #{page}"
    #     Resque.enqueue(self, user_id)
    #     break
    #   else
    #     response = JSON.parse(responseobj.body)
    #     if response.count == 0
    #       break
    #     else
    #       self.save_results(response)
    #     end
    #   end
    # end
  end

  def get_tweets
    Request.get(URL, options)
  end

  def options
    if self.last_tweet_id.nil?
      { :screen_name => self.politician.screen_name, :count => 200 }
    else
      { :screen_name => self.politician.screen_name, :count => 200, :since_id => self.last_tweet_id }
    end
  end

  def self.save_results(response)
    response.each do |response|
      TweetsByPolitician.crewait({:text => response['text'], 
                                :tweet_id => response['id'], 
                                :timestamp => response['created_at'],
                                :politician_id => self.politician.id} )
                                
    end
    puts "Completed Successfully - Stored #{response.count} Results"
  end
  
end
