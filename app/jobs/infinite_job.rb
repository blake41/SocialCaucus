class InfiniteJob < Job

	def perform
    Crewait.start_waiting
      1.upto(10000) do
        response = Request.get(self.url, options)
        case
        when server_error(response)
          puts "Error Code #{response.status}"
          self.enqueue_myself
          break
        when rate_limited(response)
          self.rate_limit << 1
          sleep_for = 5 ** self.rate_limit.count
          Kernel.sleep sleep_for
        when unauthorized(response)
          puts "User protected tweets"
          self.remove_unauthorized
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

end