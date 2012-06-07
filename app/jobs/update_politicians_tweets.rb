class UpdatePoliticiansTweets < PoliticiansTweets

  # Call perform on this class and pass in the user_id

	@queue = :update_politicians_tweets

	attr_accessor :first_tweet_id

	def initialize(user_id)
		super
		self.first_tweet_id = self.politician.first_tweet_id
	end

  def options
    { :user_id => self.politician.user_id, :count => 200, :since_id => self.first_tweet_id }
  end

  def id_to_save(tweets)
    tweets.last["id"]
  end

end