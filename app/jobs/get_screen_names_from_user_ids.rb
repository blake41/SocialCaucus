class GetScreenNamesFromUserIds < FiniteJob

	@queue = :get_screen_names

	attr_accessor :user_ids

	def initialize(user_ids)
		self.user_ids = user_ids
	end

	def self.perform(user_ids)
		self.new(user_ids).perform
	end

	def options
		{:screen_name => self.user_ids}
	end

  def self.save_results(response)
	  response.each do |user|
	    row = Politician.find_by_screen_name(:screen_name => user['screen_name'])
	    row.update_attributes(:user_id => user['id'])
	   end
  end
  

end