class GetFriends
  
  @queue = :get_friends
  
  URL = "twitter-blake41.apigee.com/1/friends/ids.json"
  URL2 = "Twitstream-uhjish.apigee.com/1/friends/ids.json"
  
  def self.perform(screen_name, user_id)
    @screen_name, @user_id = screen_name, user_id
    @responseobj = ''
    Activist.benchmark(message = "amsterdam - request") do 
      @responseobj = Request.get(URL2, {:screen_name => @screen_name })
    end
    if Request.error_check(@responseobj)
      self.clean_up_errors
    else
      Activist.benchmark(message="amsterdam - database write") do
        GetFriends.save_results
      end
    end
  end
  
  def self.clean_up_errors
    case @responseobj.code
    when 401
      Activist.where(:user_id => @user_id).update_all(:not_authorized => 1)
      puts "Updated #{@screen_name} due to #{@responseobj.code}"
    when 404
      Activist.where(:user_id => @user_id).delete_all
      PoliticiansTweetsAbout.where(:user_id => @user_id).delete_all
      puts "Deleted #{@screen_name} due to #{@responseobj.code}"
    else
      puts "Error Code #{@responseobj.code}"
      Resque.enqueue(GetFriends, @screen_name, @user_id)
    end
  end
  
  def self.save_results
    response = JSON.parse(@responseobj.body)['ids']
    Crewait.start_waiting
      response.each do |friend|
        # this should probably be just the id of the activist so we can do a has many friends
        ActivistFriend.crewait(:user_id => @user_id, 
                              :friend_id => friend)
      end
    Crewait.go!
    Activist.where(:user_id => @user_id).update_all(:friends_count => response.count)
    puts "#{response.count} Friends Saved"
  end
end