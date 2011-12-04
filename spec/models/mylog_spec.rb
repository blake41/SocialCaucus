require 'spec_helper'

describe Mylog do

  before(:each) do
    Mylog.delete_all
  end

  it "should create an error record" do

    code = 200
    page = 1
    screen_name = 'blake41'
    date = '06-26-2011'
    Mylog.log_error(code, page, screen_name, date)

    Mylog.count.should == 1
    Mylog.first.error_code.should == code 
    Mylog.first.page.should == page
    Mylog.first.screen_name.should == screen_name
    Mylog.first.until_date.should == date
    Mylog.first.since_date.should == date

  end


end