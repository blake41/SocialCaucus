require 'spec_helper'

describe PoliticiansTweetsAbout do
	
	context "#get_last_tweet_id" do
		it "should return the last tweet id for a query" do
			tweet1 = PoliticiansTweetsAbout.create(:tweet_id => 5, :keyword => "obama")
			tweet2 = PoliticiansTweetsAbout.create(:tweet_id => 9, :keyword => "obama")
			PoliticiansTweetsAbout.get_last_tweet_id("obama").should == 5
		end

		it "should return nil if theres no tweets for the query" do
			PoliticiansTweetsAbout.get_last_tweet_id("obama").should be_nil
		end
	end

end