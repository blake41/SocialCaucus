class FiniteJob < Job

  def perform
    response = Request.get(self.url, self.options)
    case
    when rate_limited(response)
      self.rate_limit << 1 
      sleep_for = 5 ** self.rate_limit.count
      puts "sleeping for #{sleep_for} seconds"
      sleep sleep_for
      self.perform
    when server_error(response)
      puts "Error Code #{response.status}"
      self.enqueue_myself
    when unauthorized(response)
      puts "Deleting user due to private account"
      self.remove_unauthorized
    else
      self.save_results(response.body)
    end
  end

end