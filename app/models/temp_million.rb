class TempMillion < ActiveRecord::Base

  def self.open_stream
    EM.run {
      username = 'blake41'
      password = 'Sp73w#W3'
      buffer = ""

      http = EventMachine::HttpRequest.new('http://stream.twitter.com/1/statuses/sample.json').post({
        :head => { 'Authorization' => [ username, password ] }
      })

      http.callback {
        unless http.response_header.status == 200
          puts "Call failed with response code #{http.response_header.status}"
        end
      }

      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r\n/)
          TempMillion.save_tweet(line)
        end
      end
    }
  end
  
  def self.save_tweet(raw_tweet)
    TempMillion.create(:raw_tweet => raw_tweet)
  end
end
