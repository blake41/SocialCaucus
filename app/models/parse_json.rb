class ParseJson < Faraday::Response::Middleware
  # def on_complete(env)
  #   # do something with the response
  #   env[:body] = JSON.parse(env[:body])
  # end
	def call(env)
	  # do something with the request
	  @app.call(env).on_complete do
	  	env[:body] = JSON.parse(env[:body]) if env[:status] == 200
	    # do something with the response
	  end
	end
end


# env is a hash
# # response phase
# :status - HTTP response status code, such as 200
# :body   - the response body
# :response_headers
