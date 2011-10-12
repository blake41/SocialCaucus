class TweetCorrect
  
  @queue = :Monitor_mentions
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  def self.perform(array)
    followers = Helpers.prepare_array(array)
    responseobj = Request.get(URL, {:screen_name => followers })
    if Request.error_check(responseobj)
      Resque.enqueue(TweetCorrect, array)
    else
      TweetCorrect.store(responseobj)      
    end
  end
  
  def self.store(responseobj)
    response = JSON.parse(responseobj.body)
    response.each do |user|
      tweet = TweetsByPolitician.where(:screen_name => user['screen_name'])
      tweet.each do |tweet|
        tweet.update_attributes(:user_id => user['id'])
      end
    end
  end

end
