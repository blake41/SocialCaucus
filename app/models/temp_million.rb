class TempMillion < ActiveRecord::Base
# TODO
# add to resque queue rather than saving right to db
# resque jobs should save to mongo
# should i be parsing in stream?
#  take params to track various terms
# 

  def open_stream
    EM.run {
      username = 'blake41'
      password = 'Sp73w#W3'
      buffer = ""
      http = EventMachine::HttpRequest.new('https://stream.twitter.com/1/statuses/sample.json').get({
        :head => { 'Authorization' => [ username, password ] }
      })
      
      self.post_init
      @parser.on_parse_complete = method(:save_tweet)
      
      
      # http.callback {
      #   unless http.response_header.status == 200
      #     puts "Call failed with response code #{http.response_header.status}"
      #   end
      # }
      # 
      # http.callback {
      #   if http.response_header.status == 200
      #     puts http.response.body
      #   end
      # 
      # }

      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r\n/)
          @parser << line
        end
      end
    }
  end
  
  def save_tweet(parsed_json)
    puts parsed_json[:text]
    TempMillion.create(:raw_tweet => parsed_json[:text])
  end
  
  def post_init
     @parser = Yajl::Parser.new(:symbolize_keys => true)
  end

  # def connection_completed
  #   # once a full JSON object has been parsed from the stream
  #   # object_parsed will be called, and passed the constructed object
  #   @parser.on_parse_complete = method(:save_tweet)
  # end
  # 
  # def receive_data(data)
  #   # continue passing chunks
  #   @parser << data
  # end
  # 
end
