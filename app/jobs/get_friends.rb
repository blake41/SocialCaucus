class GetFriends < Job
  
 # Call peform on the class, give it a user_id and the class name
  
  @queue = :get_friends
  
  URL = "/1/friends/ids.json"

  def initialize(user_id, class_name)
    @class_instance = class_name.find_by_user_id(user_id)
    self.rate_limit = []
  end

  def self.perform(user_id, class_name)
    self.new(user_id, class_name).perform
  end

  def perform
    response = Request.get(URL, self.options)
    case
    when rate_limited(response)
      debugger
      self.rate_limit << 1 
      sleep_for = 5 ** self.rate_limit.count
      puts "sleeping for #{sleep_for} seconds"
      sleep sleep_for
      self.perform
    when server_error(response)
      puts "Error Code #{response.status}"
      self.enqueue_myself
    when unauthorized(response)
      puts "Deleting user due to private account"
      @class_instance.class.name.destroy
    else
      self.save_results(response.body)
    end
  end
  
  def options
    {:user_id => @class_instance.user_id }
  end
  
  def enqueue_myself
    Resque.enqueue(self.class, @class_instance.class.name.user_id)
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