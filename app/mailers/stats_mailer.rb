class StatsMailer < ActionMailer::Base
  default :from => "blake41@gmail.com"
  
  def send_stats(recipient)
    @stats = Stat.last
    @queue = {:Monitor_mentions => Resque.size(:Monitor_mentions), :Get_Friends=>Resque.size(:Get_friends), :Get_Profiles => Resque.size(:Get_friends)}
    mail(:to=> recipient, :subject => "Stats for #{Date.today}")
  end
  
end
