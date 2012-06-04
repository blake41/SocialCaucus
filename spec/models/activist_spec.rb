require 'spec_helper'

describe Activist do
	context "#add_new_activists" do
		it "should retrieve all the new activists" do
			Activist.stubs(:new_activists => [1,2,3])
			Activist.expects(:crewait).with(:user_id => 1)
			Activist.expects(:crewait).with(:user_id => 2)
			Activist.expects(:crewait).with(:user_id => 3)
			Activist.add_new_activists
		end
	end

	context "#get_new_followers" do
		it "should enqueue get followers jobs for all activists who have no followers" do
			activist = FactoryGirl.build_stubbed(:activist)
			Activist.stubs(:without_followers => [activist])
			Resque.expects(:enqueue).with(GetFollowers, activist.user_id , "Activist")
      Activist.get_new_followers
		end
	end

	context "#get_new_friends" do
		it "should enqueue get friends jobs for all activists who have no friends" do
			activist = FactoryGirl.build_stubbed(:activist)
			Activist.stubs(:without_friends => [activist])
			Resque.expects(:enqueue).with(GetFriends, activist.user_id , "Activist")
      Activist.get_new_friends
		end
	end

	context "#get_profiles" do
		it "should enqueue a get profiles job for any activists who have no profile" do
			activist = FactoryGirl.build_stubbed(:activist)
			activist2 = FactoryGirl.build_stubbed(:activist)
			array = [activist.user_id, activist2.user_id]
			Activist.stubs(:null => array)
			Resque.expects(:enqueue).with(GetProfiles, array.join(","))
			Activist.get_profiles
		end
	end
end
