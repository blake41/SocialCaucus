class ApiBenchmark < ActiveRecord::Base

    URL = 'http://twitter-blake41.apigee.com/search.json'
    CONN = ActiveRecord::Base.connection
    @queue = :test
    
    def self.perform(date,query, x = 1)
      self.benchmark(message = 'penchmark - time to do everything') do
        until_date = date.to_date
        since_date = until_date-30.days
        highest_id = ''
        self.benchmark(message = 'penchmark - get_highest_id?') do
          if self.base_run_done?(query)
            highest_id = ''
          else
            highest_id = ''
          end 
          puts highest_id
        end
        x.upto(15) do |page|
          responseobj = ''
          self.benchmark(message = "penchmark - request") do
            responseobj = Request.get(URL,{:q => query,
                                            :rpp => 100, 
                                            :page => page, 
                                            :since => since_date.to_s,
                                            :until => until_date.to_s,
                                            :since_id => highest_id})
          end
          self.benchmark(message = "penchmark - everything but response") do
            if Request.search_error_check(responseobj, page, date)
              puts "Error Code #{responseobj.code} on page #{page}"
              # Resque.enqueue(GetActivists, date, query, page) 
              break
            else
              response = ''
              self.benchmark(message = "penchmark - parsing") do
                response = JSON.parse(responseobj.body)
              end
              if response['results'].count ==0
                if highest_id.blank?
                  self.empty_results(query)
                else
                  puts "Empty Results"
                  break
                end
              else
                self.benchmark(message = "penchmark - store results") do
                  # self.build_rows_to_insert(response, query) 
                  self.store(response, query)
                end
              end
            end
          end
        end
      end
      self.benchmark(message='penchmark - deleting records') do
        # self.delete(self.all)
      end
    end

    def self.empty_results(politician)
      pol = Politician.where(:screen_name => politician)
      pol[0].update_attributes(:search_base_run => 1)
      puts "Empty Results"
    end

    def self.base_run_done?(query)
      if Politician.where(:screen_name => query)[0].search_base_run == 1
        return true
      else
        return false
      end
    end
    
    def self.store(response, query)
      Crewait.start_waiting
        response['results'].each do |tweet|
          ApiBenchmark.crewait(:user_id => tweet['from_user_id'], 
                          :screen_name => tweet['from_user'], 
                          :text => tweet['text'],
                          :tweet_id => tweet['id'],
                          :to_user_id => tweet['to_user_id'],
                          :timestamp => Date.parse(tweet['created_at']),
                          :keyword => query)
        end
      Crewait.go!
      puts "Completed Successfully - Stored #{response['results'].count} Results"
      # total_records += response['results'].count
    end
    
    def self.build_rows_to_insert(response,query)
      big_insert_array = []
      response['results'].each do |tweet|
        insert_row = "("+"#{tweet['from_user_id']},"+"#{tweet['from_user']},"+"#{tweet['text']},"+"#{tweet['id']},"+"#{tweet['to_user_id']},"+"#{tweet['created_at']},""#{query}"+")"
        big_insert_array << insert_row
      end
      sql = "INSERT IGNORE INTO politicians_tweets_abouts (user_id, screen_name, text, tweet_id, to_user_id, timestamp, keyword) VALUES #{big_insert_array.join(", ")}" 
      CONN.execute sql      
    end
    
    def self.get_highest_id(query)
      max_tweet_id = self.where(:keyword => query).maximum(:tweet_id)
      if max_tweet_id.nil?
        return ''    
      else
        max_tweet_id
      end
    end
end
