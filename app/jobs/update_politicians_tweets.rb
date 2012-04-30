class UpdatePoliticiansTweets < PoliticiansTweets

	@queue = :update_politicians_tweets

	attr_accessor :first_tweet_id

	def initialize(user_id)
		super
		self.first_tweet_id = self.politician.first_tweet_id
	end

  def options
    { :screen_name => self.politician.screen_name, :count => 200, :since_id => self.first_tweet_id }
  end

  def save_results(tweets)
    tweets.each do |tweet|
      TweetsByPolitician.crewait({:text => tweet['text'], 
                                :tweet_id => tweet['id'], 
                                :timestamp => tweet['created_at'],
                                :politician_id => self.politician.id} )
                                
    end
    puts "Completed Successfully - Stored #{tweets.count} Results"
    self.last_tweet_id = tweets.last['id']
  end

end