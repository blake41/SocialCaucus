class GetPoliticiansTweets < PoliticiansTweets

  # Call perform on the class and pass in the id

  @queue = :get_politicians_tweets

  attr_accessor :last_tweet_id

  def initialize(user_id)
    super
    self.last_tweet_id ||= self.politician.last_tweet_id
  end

  def options
    hash = { :user_id => self.politician.user_id, :count => 200 }
    self.last_tweet_id.nil? ? hash : hash.merge!(:max_id => self.last_tweet_id)
  end

  def id_to_save(tweets)
    tweets.last['id'] - 1
  end

end