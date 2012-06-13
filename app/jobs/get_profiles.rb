class GetProfiles < FiniteJob
  
  @queue = :get_profiles

  def initialize(user_ids)
    @user_ids = user_ids
    self.rate_limit = []
    self.url = '/1/users/lookup.json'
  end

  def self.perform(user_ids)
    self.new(user_ids).perform
  end

  def options
    {:user_id => @user_ids}
  end

  def enqueue_myself
    Resque.enqueue(self.class, @user_ids)
  end

  def remove_unauthorized
    true
  end

  def save_results(response)
    response.each do |user|
      Activist.update_all({:screen_name => user["screen_name"],
                          :description => user['description'], 
                          :location => user['location']
      })
    end
    puts "#{response.count} Profiles Saved"
  end
end