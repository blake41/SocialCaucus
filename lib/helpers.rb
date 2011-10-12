class Helpers
  
  def self.prepare_array(array)
    newarray = array.collect {|item| item.screen_name}
    newarray.join(",")
  end
  
  def self.prepare_user_array(array)
    newarray = array.collect {|item| item.user_id}
    newarray.join(",")
  end
end