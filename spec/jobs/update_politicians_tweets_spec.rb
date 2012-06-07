require 'spec_helper'

describe GetPoliticiansTweets do

	context "#initialize" do
		it "should set the first tweet id to the instance of the politicians first tweet id" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:first_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = UpdatePoliticiansTweets.new(pol.user_id)
			gpt.first_tweet_id.should  == 25
		end
	end

	context "#id_to_save" do
		it "should return the first id of the tweets" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:first_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = UpdatePoliticiansTweets.new(pol.user_id)
			tweets = [{"id" => 7}, {"id" => 9}, {"id" => 3}]
			gpt.id_to_save(tweets).should == 3
		end
	end

	context "#options" do
		it "should return the max id in the hash if we have a first tweet id" do
			pol = Politician.new(:user_id => 7)
			pol.stubs(:first_tweet_id => 25)
			Politician.stubs(:find_by_id => pol)
			gpt = UpdatePoliticiansTweets.new(pol.user_id)
			gpt.options.should == { :user_id => 7, :count => 200, :since_id => 25}
		end
	end
end