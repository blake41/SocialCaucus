require 'spec_helper'

describe GetProfiles do
	
	it "should enqueue itself if we get a 500 level error" do
		mock = Object.new
		mock.stubs(:status => 500)
		Request.stubs(:get => mock)
		GetProfiles.any_instance.expects(:enqueue_myself)
		GetProfiles.perform("1,2")
	end

	it "should enqueue itself if we get a 500 level error" do
		mock = Object.new
		mock.stubs(:status => 501)
		Request.stubs(:get => mock)
		GetProfiles.any_instance.expects(:enqueue_myself)
		GetProfiles.perform("1,2")
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
		GetProfiles.any_instance.expects(:enqueue_myself).once
		GetProfiles.perform("1,2")
	end

	it "should call save results with the body of the response when we have a 200 that's not empty" do
		mock = Object.new
		mock.stubs(:status => 200, :body => [{}])
		Request.stubs(:get).returns(mock)
		GetProfiles.any_instance.expects(:save_results).with(mock.body)
		GetProfiles.perform("1,2")
	end

	it "should save the results with the body of the response" do
		profile = {"screen_name" => 123, "description" => "so cool", "location" => "some location"}
		profiles = [profile, profile]
		instance = GetProfiles.new("1,2")
		Activist.expects(:update_all).with({:screen_name => profile['screen_name'], 
		                        								:description => profile['description'],
		                        								:location => profile['location']
																			})
		Activist.expects(:update_all).with({:screen_name => profile['screen_name'], 
		                        								:description => profile['description'],
		                        								:location => profile['location']
																			})
		instance.save_results(profiles)
	end

end