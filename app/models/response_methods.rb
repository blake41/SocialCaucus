module ResponseMethods
	def server_error(response)
    if response.status > 499
      true
    else
      false
    end
	end
end
