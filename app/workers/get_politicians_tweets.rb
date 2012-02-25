class GetPoliticiansTweets
  
  @queue = :Politicians_tweets
  
  URL = "twitter-blake41.apigee.com/1/statuses/user_timeline.json"

  def self.perform(user_id, start_page = 1)
    @user = Politician.find(user_id)
    @screen_name = @user.screen_name
    start_page.upto(10000) do |page|
      if self.base_run_done?
        tweets = TweetsByPolitician.where(:screen_name => @screen_name).order("tweet_id DESC")
        responseobj= self.get_newest_tweets(page, tweets)   
      else
        responseobj = self.get_first_tweets(page)                                 
      end
      if Request.error_check(responseobj, page, @screen_name)
        puts "Error Code #{responseobj.code} on page #{page}"
        Resque.enqueue(self, user_id, page)
        break
      else
        response = JSON.parse(responseobj.body)
        if response.count ==0
          self.empty_results
          break
        else
        self.save_results(response)
        end
      end
    end
  end
  
  
  def self.base_run_done?
    if Politician.where(:screen_name => @screen_name)[0].base_run_done == 1
      return true
    else
      return false
    end
  end
  
  def self.empty_results
    pol = Politician.where(:screen_name => @screen_name)
    pol[0].update_attributes(:base_run_done => 1)
    puts "Empty response"
  end
  
  def self.get_newest_tweets(page, tweets)
    highestid = tweets.first.tweet_id
    Request.get(URL, { :screen_name => @screen_name, 
                      :count => 200, 
                      :page => page, 
                      :since_id => highestid })
  end
  
  def self.get_first_tweets(page)
    Request.get(URL, { :screen_name => @screen_name, 
                      :count => 200, 
                      :page => page })
  end

  def self.save_results(response)
    response.each do |response|
      TweetsByPolitician.create({:screen_name => @screen_name, 
                                :text => response['text'], 
                                :tweet_id => response['id'], 
                                :timestamp => response['created_at'],
                                :user_id => response['user']['id']} )
    end
    puts "Completed Successfully - Stored #{response.count} Results"
  end
  
end
