class GetRelations < FiniteJob

	def initialize(user_id, class_name)
    @class_instance = class_name.find_by_user_id(user_id)
    self.rate_limit = []
  end

  def self.perform(user_id, class_name)
    self.new(user_id, class_name).perform
  end
  
  def remove_unauthorized
    @class_instance.class.name.destroy
  end

  def options
    {:user_id => @class_instance.user_id }
  end
  
  def enqueue_myself
    Resque.enqueue(self.class, @class_instance.class.name.user_id)
  end

end