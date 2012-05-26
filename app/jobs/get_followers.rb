class GetFollowers < GetFriends
  
  # Call peform on the class, give it a user_id and the class name

  @queue = :get_followers

  URL = "/1/followers/ids.json"
  
  def save_results(response)
    ids = response['ids']
    Crewait.start_waiting
      ids.each do |friend|
        Kernel.const_get("#{@class_instance.class.name}sFollower").crewait("#{@class_instance.class.name.downcase}_id".to_sym => @class_instance.id, 
                              :follower_id => friend)
      end
    Crewait.go!
    @class_instance.update_attributes(:followers_count => ids.count) if @class_instance == "Activist"
    puts "#{ids.count} Followers Saved"
  end

end