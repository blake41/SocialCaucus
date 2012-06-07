require 'spec_helper'

describe GetPoliticiansTweets do

	context "#initialize" do
		it "should set the politician to the instance of the politician" do
			pol = Politician.new(:user_id => 7)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			gpt.politician.should == pol
		end

		it "should set the last tweet id to the instance of the politicians last tweet id" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:last_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			gpt.last_tweet_id.should  == 25
		end
	end

	context "#save_results" do	
		it "should save the results with the body of the response" do
			tweet = {"text" => 'hello', "id" => 1, "created_at" => "Thu, 06 Oct 2011 19:36:17 +0000"}
			tweets = [tweet]
			pol = Politician.new
			pol.stubs(:id => 5, :user_id => 15)
			GetPoliticiansTweets.any_instance.stubs(:politician => pol)
			instance = GetPoliticiansTweets.new(pol.user_id)
			TweetsByPolitician.expects(:crewait).with({:text => tweet['text'], 
	                                :tweet_id => tweet['id'], 
	                                :timestamp => tweet['created_at'],
	                                :politician_id => 5})
			instance.save_results(tweets)
		end
	end

	context "#id_to_save" do
		it "should return the last id of the tweets" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:last_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			tweets = [{"id" => 7}, {"id" => 9}, {"id" => 3}]
			gpt.id_to_save(tweets).should == 2
		end
	end

	context "#options" do
		it "should return the max id in the hash if we have a last tweet id" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:last_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			gpt.options.should == { :user_id => 7, :count => 200, :max_id => 25}
		end
	end

	context "#options" do
		it "should not include the max id in the has if we don't have a last tweet id" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:last_tweet_id => nil)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			gpt.options.should == { :user_id => 7, :count => 200 }
		end
	end

	context "#remove_unauthorized" do
		it "should call destroy on the politicians instance" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:last_tweet_id => nil)
			Politician.stubs(:find_by_id => pol)
			gpt = GetPoliticiansTweets.new(pol.user_id)
			pol.expects(:destroy)
			gpt.remove_unauthorized
		end
	end
end