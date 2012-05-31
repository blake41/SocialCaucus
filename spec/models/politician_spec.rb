require 'spec_helper'

describe Politician do
  
  before(:each) do
    Politician.delete_all
    # Resque.remove_queue(:Politicians_tweets)
    # Resque.remove_queue(:Get_politicians_friends)
  end
  
  it "should get and save the username of the politician" do
    pol = Politician.new(:screen_name => "MicheleBachmann")
    pol2 = Politician.new(:screen_name => 'DrRandPaul')
    # Request.expects(:get).with({:screen_name => ["MicheleBachmann", "DrRandPaul"].join(",")}).returns()
    Politician.stubs(:get_screen_names => [pol.screen_name, pol2.screen_name])
    Politician.get_user_id_from_screen_name
    Resque.expects(:enqueue).with(GetScreenNamesFromUserIds, ["MicheleBachmann", "DrRandPaul"].join(","))
    # Resque.size(:get_screen_names).should == 2
    # pol.reload.user_id.should == 18217624
    # pol2.reload.user_id.should == 39834947
  end
  
  it "should add a bunch of politicians to the get politicians tweets resque queue" do
    pol = FactoryGirl.build_stubbed(:politician)
    Politician.stubs(:all => [pol])
    Resque.expects(:enqueue).with(GetPoliticiansTweets, pol.id)
    Politician.get_tweets_by_politicians
    # Resque.size(:Politicians_tweets).should == 1
  end
  
  # it "should find a politician by their screen_name and update their user_id" do
  #   politician = Factory.create(:politician, :user_id => 1234)
  #   user = {'screen_name' => 'MicheleBachmann', 'id' => 18217624}
  #   Politician.save_user(user)
  #   politician.reload.user_id.should == 18217624
  # end
  
  it "should add a bunch of politicians friends to the resque queue" do
    pol = FactoryGirl.build_stubbed(:politician)
    Politician.stubs(:without_friends => [pol])
    Resque.expects(:enqueue).with(GetFriends, pol.user_id , "Politician")
    Politician.get_new_politicians_friends
    # Resque.size(:Get_politicians_friends).should == 1
  end
  
  it "should add a bunch of politicians to the get follower resque queue" do
    pol = FactoryGirl.build_stubbed(:politician)
    Politician.stubs(:without_followers => [pol])
    Resque.expects(:enqueue).with(GetFollowers, pol.user_id , "Politician")
    Politician.get_new_politicians_followers
    # Resque.size(:Get_politicians_friends).should == 1
  end

end
  
  