require 'spec_helper'

describe Job do
	
	it "should break on server error" do
		mock = Object.new
		mock.stubs(:status => 500)
		Request.stubs(:get => mock)
		GetActivists.perform("obama")
		GetActivists.any_instance.expects(:enqueue_myself)
	end	

end