class Search
	
  def self.query(args)
    scope = PoliticiansTweetsAbout.scoped
    scope = scope & select('*')
    scope = scope & where("text like ?", "%"+args[:user_name]+"%") unless args[:user_name].blank?
    scope = scope & PoliticiansTweetsAbout.location.where("location like ?","%"+args[:location]+"%") unless args[:location].blank?
    scope = scope & PoliticiansTweetsAbout.description.where("description like ?","%"+args[:description]+"%") unless args[:description].blank?
    return scope
  end
end
