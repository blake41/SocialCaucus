require 'spec_helper'

describe Activist do
	
	before(:all) do
		PoliticiansTweetsAbout.delete_all
		@tweet = FactoryGirl.create(:politicians_tweets_about)
	end

	context "#new_activists" do
		it "should return all the new activists" do
			tweet2 = FactoryGirl.create(:politicians_tweets_about, :activist_id => 123, :tweet_id => 7)
			activist = FactoryGirl.create(:activist, :user_id => 123)
			Activist.new_activists.should == [@tweet.activist_id]
		end
	end

	context "#null" do
		it "should return all activists whose user ids are null" do
			activist = Activist.create(:screen_name => "heyma")
			activist2 = FactoryGirl.create(:activist)
			Activist.null.should == [activist.screen_name]
		end
	end

	context "#without_friends" do
		it "should return all the activists who have no friends" do
			activist = FactoryGirl.create(:activist, :screen_name => "whatever")
			activist2 = FactoryGirl.create(:activist, :friends_count => 4, :screen_name => "whateverrrr")
			[Activist.new(:user_id => activist.user_id)] == Activist.without_friends.should
		end
	end

	context "without_followers" do
		it "should return all the activists who have no followers" do
			activist = FactoryGirl.create(:activist, :screen_name => "yo ma")
			activist2 = FactoryGirl.create(:activist, :followers_count => 5, :screen_name => "adam")
			[Activist.new(activist.user_id)] == Activist.without_followers.should
		end
	end
end