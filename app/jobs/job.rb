class Job

	include ResponseMethods
  attr_accessor :screen_name, :user_id, :rate_limit, :politician, :url

  def rate_limited(response)
    if response.status == 420 || response.status == 400
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
end