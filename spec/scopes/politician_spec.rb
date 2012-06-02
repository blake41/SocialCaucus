require 'spec_helper'

describe Politician do

	before(:all) do
		Politician.delete_all
		@pol = FactoryGirl.create(:politician)
	end

  context "scopes" do

    context "get_screen_names" do
      it "should return a list of screen names" do
      	# pol = FactoryGirl.create(:politician)
      	Politician.get_screen_names.should == ["MicheleBachmann"]
      end
    end

    context "without_followers" do
      it "should return a list of user_ids that have no followers yet" do
      	# no idea why these have to be backwards
      	[Politician.new(:user_id => @pol.user_id)].should == Politician.without_followers
      end
    end

    context "without_friends" do
      it "should return a list of user_ids that have no friends yet" do
      	# no idea why these have to be backwards
      	[Politician.new(:user_id => @pol.user_id)].should == Politician.without_friends
      end
    end
  end
end