require 'rubygems'
require 'eventmachine'

EM.run {
  require 'em-http'

  EM::HttpRequest.new('http://json-time.appspot.com/time.json').get.callback { |http|
    puts http.response
  }
}