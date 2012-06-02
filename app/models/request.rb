class Request
  
  def self.get(url, args)
    conn = Faraday.new(:url => "http://twitter-blake41.apigee.com") do |builder|
      builder.use ParseJson
      builder.adapter :typhoeus
    end
    conn.get do |req|
      req.url(url, args)
    end
  end
  
end