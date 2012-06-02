class GetProfiles < FiniteJob
  
  @queue = :get_profiles

  def initialize(screen_names)
    @screen_names = screen_names
    self.rate_limit = []
    self.url = '/1/users/lookup.json'
  end

  def self.perform(screen_names)
    self.new(screen_names).perform
  end

  def options
    {:screen_names =>  @screen_names}
  end

  def enqueue_myself
    Resque.enqueue(self.class, @screen_names)
  end

  def remove_unauthorized
    true
  end

  def save_results(response)
    response.each do |user|
      Activist.update_all({:screen_name => user['screen_name'], 
                          :description => user['description'], 
                          :location => user['location']}, "user_id = #{user['id']}")
    end
    puts "#{response.count} Profiles Saved"
  end
  
  # def self.get_individual_profiles(string_array)
  #   array = string_array.split(",")
  #   array.each do |screen_name|
  #     Resque.enqueue(GetIndividualProfile, screen_name )
  #   end
  # end
end