class Request
  
  def self.get(url, args)
    Typhoeus::Request.get(url, :params => args)
  end
  
  def self.search_error_check(responseobj, page, date)
    if Request.invalid_error_code?(responseobj, page, date)
      return true 
    else
      response = JSON.parse(responseobj.body)
      Request.empty_response(page) if response['results'].empty?
      return false
    end
  end

  def self.error_check(responseobj, page = 0, user = '')
    if Request.invalid_error_code?(responseobj, page, user)
      return true 
    else
      response = JSON.parse(responseobj.body)
      Request.empty_response(page, user) if response.empty?
      return false
    end
  end
  
  def self.invalid_error_code?(responseobj, page = 0, date = '', user = '')
    Mylog.log_error(responseobj.code, page, user, date) if responseobj.code > 200
  end

  def self.empty_response(page, user = '', date = '')
    Mylog.log_error(999, page, user, date) if page == 1
  end
  
end