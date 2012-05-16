class Job

	include ResponseMethods
  attr_accessor :screen_name, :user_id, :rate_limited, :politician

	def perform
    Crewait.start_waiting
      1.upto(10000) do
        response = self.get_tweets
        case
        when server_error(response)
          puts "Error Code #{response.status}"
          self.enqueue_myself
          break
        when rate_limited(response)
          self.rate_limit << 1 
          sleep_for = 5 ** self.rate_limit.count
          sleep sleep_for
        when unauthorized(response)
          debugger
          puts "User protected tweets"
          self.politician.destroy
          break
        when empty(response)
          puts "Empty response"
          break
        else
          self.save_results(response.body)
        end
      end
    Crewait.go!
  end
  
  def rate_limited(response)
    if response.status == 420
      true
    else
      false
    end
  end

  def empty(response)
    if response.body.count == 0
      true
    else
      false
    end
  end

  def unauthorized(response)
    if 399 < response.status && response.status < 499
      true
    else
      false  
    end
  end

  def get_tweets
    Request.get(self.url, options)
  end

end