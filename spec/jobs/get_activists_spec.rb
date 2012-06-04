require 'spec_helper'

describe GetActivists do
	
	it "should enqueue itself if we get a 500 level error" do
		mock = Object.new
		mock.stubs(:status => 500)
		Request.stubs(:get => mock)
		GetActivists.any_instance.expects(:enqueue_myself)
		GetActivists.perform("obama")
	end

	it "should enqueue itself if we get a 500 level error" do
		mock = Object.new
		mock.stubs(:status => 501)
		Request.stubs(:get => mock)
		GetActivists.any_instance.expects(:enqueue_myself)
		GetActivists.perform("obama")
	end	
	
	it "should sleep for 5 seconds * number of times we've been rate limited each time we get a 400 or 420 and exit when we hit the 500" do
		mock = Object.new
		mock.stubs(:status => 420)
		mock2 = Object.new
		mock2.stubs(:status => 400)
		mock3 = Object.new
		mock3.stubs(:status => 500)
		Request.stubs(:get).returns(mock, mock2, mock3)
		Kernel.expects(:sleep).with(5)
		Kernel.expects(:sleep).with(25)
		GetActivists.any_instance.expects(:enqueue_myself).once
		GetActivists.perform("obama")
	end

	it "should call save results with the body of the response when we have a 200 that's not empty" do
		mock = Object.new
		mock.stubs(:status => 200, :body => {"results" => [1]})
		mock2 = Object.new
		mock2.stubs(:status => 500)
		Request.stubs(:get).returns(mock, mock2)
		GetActivists.any_instance.expects(:enqueue_myself).once
		GetActivists.any_instance.expects(:save_results).with(mock.body)
		GetActivists.perform("obama")
	end

	it "should save the results with the body of the response" do
		tweet = {"from_user_id" => 123, "text" => 'hello', "id" => 1, "to_user_id" => 7, "created_at" => "Thu, 06 Oct 2011 19:36:17 +0000"}
		tweets = [tweet]
		hash = {"results" => tweets}
		instance = GetActivists.new("obama")
		PoliticiansTweetsAbout.expects(:crewait).with(:activist_id => tweet['from_user_id'], 
                        :text => tweet['text'],
                        :tweet_id => tweet['id'],
                        :to_user_id => tweet['to_user_id'],
                        :timestamp => Date.parse(tweet['created_at']),
                        :keyword => instance.query)
		instance.save_results(hash)
	end

end