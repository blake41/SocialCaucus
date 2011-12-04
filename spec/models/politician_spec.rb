require 'spec_helper'

describe Politician do
  
  before(:each) do
    Politician.delete_all
    Resque.remove_queue(:Politicians_tweets)
    Resque.remove_queue(:Get_politicians_friends)
  end
  
  it "should get and save the username of the politician" do
    VCR.use_cassette "lookup" do
      pol = Factory.create(:politician, :user_id => 1234)
      pol2 = Factory.create(:politician, :screen_name => 'DrRandPaul', :user_id => 456)
      Politician.get_user_id_from_screen_name
      pol.reload.user_id.should == 18217624
      pol2.reload.user_id.should == 39834947
    end
  end
  
  it "should add a bunch of politicians to the resque queue" do
    Factory.create(:politician)
    Politician.get_tweets_by_politicians
    Resque.size(:Politicians_tweets).should == 1
  end
  
  it "should find a politician by their screen_name and update their user_id" do
    politician = Factory.create(:politician, :user_id => 1234)
    user = {'screen_name' => 'MicheleBachmann', 'id' => 18217624}
    Politician.save_user(user)
    politician.reload.user_id.should == 18217624
  end
  
  it "should add a bunch of politicians to the resque queue" do
    Factory.create(:politician)
    Politician.get_politicians_friends
    Resque.size(:Get_politicians_friends).should == 1
  end
  

end
  
  