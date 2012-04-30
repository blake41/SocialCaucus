class GetProfiles
  
  @queue = :get_profiles
  
  URL = 'twitter-blake41.apigee.com/1/users/lookup.json'

  def self.perform(array)
    responseobj = Request.get(URL, {:screen_name => array })
    if Request.error_check(responseobj)
      if responseobj.code == 404
        GetProfiles.get_individual_profiles(array)
      else
        Resque.enqueue(GetProfiles, array)
        puts "Error Code #{responseobj.code}"
      end
    else  
      GetProfiles.save_profile(responseobj)
    end
  end
  
  def self.save_profile(responseobj)
    response = JSON.parse(responseobj.body)
    response.each do |user|
      Activist.where(:screen_name => user['screen_name']).limit(1).update_all({:follower_count => user['followers_count'], 
                                    :screen_name => user['screen_name'], 
                                    :description => user['description'], 
                                    :location => user['location'], 
                                    :user_id => user['id']})
    end
    puts "#{response.count} Profiles Saved"
  end
  
  def self.get_individual_profiles(string_array)
    array = string_array.split(",")
    array.each do |screen_name|
      Resque.enqueue(GetIndividualProfile, screen_name )
    end
  end
end