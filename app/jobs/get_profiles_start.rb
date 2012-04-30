class GetProfilesStart
  
  @queue = :get_profiles
  
  def self.perform
    Task.get_profiles if Resque.size(:get_individual_profile)==0
  end
  
end