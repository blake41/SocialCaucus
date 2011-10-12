class Mylog < ActiveRecord::Base
  
  def self.log_error(code, page = 0, user = '', date = '')
    Mylog.create(:error_code => code, 
                  :page => page, 
                  :screen_name => user, 
                  :until_date => date, 
                  :since_date => date)
  end
  
end
