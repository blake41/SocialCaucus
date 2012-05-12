class GetPoliticiansFriends
  
  @queue = :Get_politicians_friends
  
  URL = "twitter-blake41.apigee.com/1/friends/ids.json"
  
  def self.perform(user_id)
    @user = Politician.find(user_id)
    responseobj = Request.get(URL, {:screen_name => @user.screen_name })
    if error = Request.error_check(responseobj, 0, @user)
      Resque.enqueue(GetFriends, user_id)
    else
      puts 'Saving'
      GetPoliticiansFriends.save_results(responseobj) 
      puts "Saved #{@user.screen_name}'s friends"
    end
  end
  
  def self.save_results(responseobj)
    response = JSON.parse(responseobj.body)['ids']
    response.each do |friend|
      # this should be user_id so that that politician has many friends
      PoliticiansFriend.create(:user_id => @user.user_id, 
                            :friend_id => friend)
    end
  end
end