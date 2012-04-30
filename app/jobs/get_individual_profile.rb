class GetIndividualProfile
  
  @queue = :get_individual_profile
  
  URL = 'twitter-blake41.apigee.com/1/users/lookup.json'
  
  def self.perform(screen_name)
    responseobj = Request.get(URL, {:screen_name => screen_name })
    if Request.error_check(responseobj)
      if responseobj.code == 404
        Activist.where(:screen_name => screen_name).delete_all
        PoliticiansTweetsAbout.where(:screen_name => screen_name).delete_all
      else
        Resque.enqueue(GetIndividualProfile, screen_name)
        puts "Error Code #{responseobj.code}"
      end
    else  
      GetProfiles.save_profile(responseobj)
      puts 'It worked!'
    end
    self.am_i_last?
  end

  def self.am_i_last?
    Task.get_profiles if Resque.size(:get_friends)==0 && Resque.size(:get_individual_profile)==1
  end
  
  def self.save_profile(responseobj)
    response = JSON.parse(responseobj.body)
    Activist.where(:screen_name => response['screen_name']).limit(1).update_all({:follower_count => response['followers_count'], 
                                    :screen_name => response['screen_name'], 
                                    :description => response['description'], 
                                    :location => response['location'], 
                                    :user_id => response['id']})
    puts "#{response.count} Profiles Saved"
  end  
  
end