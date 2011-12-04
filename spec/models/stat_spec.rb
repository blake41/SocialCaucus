require 'spec_helper'

describe Stat do

  it "should return the average number of tweets per day" do
    debugger
    Factory.create(:politicians_tweets)
    PoliticiansTweetsAbout.stubs(:count).with(15)
    Date.stubs(:today).with('Thu, 20 Oct 2011')
    Stat.average_number_of_tweets_per_day.should == 1 

  end

end