class GetFriends < Job
  
  @queue = :get_friends
  
  URL = "/1/friends/ids.json"

  def initialize(user_id, class_name)
    @class_instance.class.name = class_name.find_by_user_id(user_id)
  end

  def self.perform(user_id)
    self.new(user_id).perform
  end

  def perform
    response = Request.get(URL, self.options)
    case
    when server_error(response)
      puts "Error Code #{response.status}"
      self.enqueue_myself
      break
    when unauthorized(response)
      puts "Deleting user due to private account"
      @class_instance.class.name.destroy
      break
    else
      self.save_results(response.body)
    end
  end
  
  def options
    {:user_id => @class_instance.class.name.user_id }
  end
  
  def enqueue_myself
    Resque.enqueue(self.class, @class_instance.class.name.user_id)
  end

  def save_results(response)
    ids = response.body['ids']
    Crewait.start_waiting
      ids.each do |friend|
        # this should probably be just the id of the activist so we can do a has many friends
        ActivistFriend.crewait("#{@class_instance.class.name.downcase}_id".to_sym => @class_instance.id, 
                              :friend_id => friend)
      end
    Crewait.go!
    @class_name.update_all(:friends_count => ids.count)
    puts "#{ids.count} Friends Saved"
  end
end