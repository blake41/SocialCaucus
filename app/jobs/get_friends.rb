class GetFriends < GetRelations
  
 # Call peform on the class, give it a user_id and the class name

  @queue = :get_friends
  
  def initialize(user_id, class_name)
    super
    self.url = "/1/friends/ids.json"
  end

  def save_results(response)
    ids = response['ids']
    Crewait.start_waiting
      ids.each do |friend|
        Kernel.const_get("#{@class_instance.class.name}sFriend").crewait("#{@class_instance.class.name.downcase}_id".to_sym => @class_instance.id, 
                              :friend_id => friend)
      end
    Crewait.go!
    @class_instance.update_attributes(:friends_count => ids.count) if @class_instance.class.name == "Activist"
    puts "#{ids.count} Friends Saved"
  end
end