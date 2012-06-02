require 'spec_helper'

describe Politician do

  context "get_user_id_from_screen_name" do
    it "should get and save the username of the politician" do
      pol = Politician.new(:screen_name => "MicheleBachmann")
      pol2 = Politician.new(:screen_name => 'DrRandPaul')
      array = [pol.screen_name, pol2.screen_name]
      Politician.stubs(:get_screen_names => array)
      Resque.expects(:enqueue).with(GetScreenNamesFromUserIds, array.join(","))
      Politician.get_user_id_from_screen_name
    end
  end

  context "#last_tweet_id" do
    it "should return the last tweet id" do
      t1 = TweetsByPolitician.new(:tweet_id => 3)
      t2 = TweetsByPolitician.new(:tweet_id => 4)
      pol = Politician.new
      pol.stubs(:tweets => [t2,t1])
      pol.last_tweet_id.should == 4
    end

    it "should return nil if there's no tweets" do
      pol = Politician.new
      pol.last_tweet_id.should == nil
    end
  end

  context "#first_tweet_id" do
    it "should return the first tweet id" do
      t1 = TweetsByPolitician.new(:tweet_id => 3)
      t2 = TweetsByPolitician.new(:tweet_id => 4)
      pol = Politician.new
      pol.stubs(:tweets => [t2,t1])
      pol.first_tweet_id.should == 3
    end

    it "should return nil if there's no tweets" do
      pol = Politician.new
      pol.first_tweet_id.should == nil
    end
  end

  context "#get_tweets_by_politicians" do
    it "should add a bunch of politicians to the get politicians tweets resque queue" do
      pol = FactoryGirl.build_stubbed(:politician)
      Politician.stubs(:all => [pol])
      Resque.expects(:enqueue).with(GetPoliticiansTweets, pol.id)
      Politician.get_tweets_by_politicians
    end
  end

  context "#get_new_friends" do
    it "should add a bunch of politicians friends to the resque queue" do
      pol = FactoryGirl.build_stubbed(:politician)
      Politician.stubs(:without_friends => [pol])
      Resque.expects(:enqueue).with(GetFriends, pol.user_id , "Politician")
      Politician.get_new_friends
    end
  end

  context "#get_new_followers" do  
    it "should add a bunch of politicians to the get follower resque queue" do
      pol = FactoryGirl.build_stubbed(:politician)
      Politician.stubs(:without_followers => [pol])
      Resque.expects(:enqueue).with(GetFollowers, pol.user_id , "Politician")
      Politician.get_new_followers
    end
  end

end
  
  