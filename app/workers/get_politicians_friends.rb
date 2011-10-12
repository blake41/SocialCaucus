class GetPoliticiansFriends
  
  @queue = :Get_politicians_friends
  
  URL = "twitter-blake41.apigee.com/1/friends/ids.json"
  
  def self.perform(user_id)
    debugger
    @user = Politician.find(user_id)
    responseobj = Request.get(URL, {:screen_name => @user.screen_name })
    if Request.error_check(responseobj, 0, @user)
      Resque.enqueue(GetFriends, user_id)
    else
      GetPoliticiansFriends.save_results(responseobj) 
    end
  end
  
  def self.save_results(responseobj)
    response = JSON.parse(responseobj.body)
    response.each do |friend|
      PoliticiansFriend.create(:user_id => @user.user_id, 
                            :friend_id => friend)
    end
  end
end