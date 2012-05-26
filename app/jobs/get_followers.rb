class GetFollowers < GetRelations
  
  # Call peform on the class, give it a user_id and the class name

  @queue = :get_followers

  def initialize(user_id, class_name)
    super
    self.url = "/1/followers/ids.json"
  end

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