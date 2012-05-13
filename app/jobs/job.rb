class Job

	include ResponseMethods
  attr_accessor :screen_name
  attr_accessor :user_id
  attr_accessor :politician

	def perform
    Crewait.start_waiting
      1.upto(10000) do
        response = self.get_tweets
        case
        when server_error(response)
          puts "Error Code #{response.status}"
          self.enqueue_myself
          break
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