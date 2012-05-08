class GetActivists
  
  @queue = :get_mentions
  
  URL = '/search.json'
  
  def self.perform(date,query, x = 1)
    until_date = date.to_date
    since_date = until_date-30.days
    if GetActivists.base_run_done?(query)
      highest_id = PoliticiansTweetsAbout.get_highest_id(query)
    else
      highest_id = ''
    end
    x.upto(15) do |page|
      responseobj = ''
      Activist.benchmark(message="salzburg - request") do
        responseobj = Request.get(URL,{:q => query,
                                        :rpp => 100, 
                                        :page => page, 
                                        :since => since_date.to_s,
                                        :until => until_date.to_s,
                                        :since_id => highest_id})
      end
      if Request.search_error_check(responseobj, page, date)
        puts "Error Code #{responseobj.code} on page #{page}"
        Resque.enqueue(GetActivists, date, query, page) 
        break
      else
        response = ''
        Activist.benchmark(message = 'salzburg - json') do
          response = JSON.parse(responseobj.body)
        end
        if response['results'].count ==0
          if highest_id.blank?
            GetActivists.empty_results(query)
            break
          else  
            puts 'Empty Results'
            break
          end
        else
          Activist.benchmark(message = "salzburg - database") do
            GetActivists.store(response, query) 
          end
        end
      end
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
        PoliticiansTweetsAbout.crewait(:user_id => tweet['from_user_id'], 
                        :screen_name => tweet['from_user'], 
                        :text => tweet['text'],
                        :tweet_id => tweet['id'],
                        :to_user_id => tweet['to_user_id'],
                        :timestamp => Date.parse(tweet['created_at']),
                        :keyword => query)
      end
    Crewait.go!
    puts "Attempted to insert #{response['results'].count} results"
  end
end

