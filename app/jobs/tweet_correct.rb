class TweetCorrect
  
  extend SocialCaucus::ResponseMethods
  
  @queue = :Monitor_mentions
  
  URL = "twitter-blake41.apigee.com/1/users/lookup.json"
  
  def self.perform(followers)
    response = Request.get(URL, {:screen_name => followers })
    case 
    when self.error(response)
      Resque.enqueue(TweetCorrect, followers)
    else
      self.save_results(response.body)     
    end
  end

  def self.save_results(response)
    response.each do |user|
      tweet = TweetsByPolitician.find_by_screen_name(user['screen_name'])
      tweet.update_attributes(:user_id => user['id'])
    end
  end

end
