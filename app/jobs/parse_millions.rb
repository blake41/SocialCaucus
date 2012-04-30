class ParseMillions
  
  @queue = :Parse_millions
  
  def self.perform(item_id)
    row = TempMillion.find(item_id)
    parsed_row = JSON.parse(row.raw_tweet)
    ParseMillions.save(parsed_row)
  end
  
  def self.save(tweet)
    Million.create(:text => tweet['text'],
                    :tweet_id=> tweet['id'],
                    :user_id => tweet['user']['id'],
                    :timestamp => tweet['created_at'],
                    :screen_name => tweet['user']['screen_name'])
  end
  
end
