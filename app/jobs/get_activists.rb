class GetActivists < Job
  
  @queue = :get_mentions
  
  attr_accessor :url, :query, :last_tweet_id
  
  def initialize(query)
    self.query = query
    self.url = '/search.json'
    self.last_tweet_id = PoliticiansTweetsAbout.get_last_tweet_id(query)
  end

  def self.perform(query)
    self.new(query).perform
  end

  def options
    hash = {:q => self.query, :rpp => 100}
    if self.last_tweet_id.nil?
      hash
    else
      hash.merge!(:max_id => self.last_tweet_id)
    end
  end

  def empty(response)
    if response.body['results'].count == 0
      true
    else
      false
    end
  end

  def save_results(tweets)
    Crewait.start_waiting
      tweets['results'].each do |tweet|
        PoliticiansTweetsAbout.crewait(:activist_id => tweet['from_user_id'], 
                        :text => tweet['text'],
                        :tweet_id => tweet['id'],
                        :to_user_id => tweet['to_user_id'],
                        :timestamp => Date.parse(tweet['created_at']),
                        :keyword => query)
      end
    Crewait.go!
    self.last_tweet_id = tweets['results'].last['id']
    puts "largest record is #{tweets['results'].first['id']}"
    puts "smallest recrod is #{tweets['results'].last['id']}"
    puts "Attempted to insert #{tweets['results'].count} results"
    puts self.last_tweet_id
  end
end

