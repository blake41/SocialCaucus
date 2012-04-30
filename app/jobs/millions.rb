# class Millions
#   
#   @queue = :Get_millions
#   
#   URL = "twitter-blake41.apigee.com/1/.json"
#   
#   def self.perform
#     @user = Activist.where(:user_id => user_id)[0]
#     responseobj = Request.get(URL, {:screen_name => @user.screen_name })
#     puts "#{responseobj.headers_hash['X-Ratelimit-Remaining']} calls left this hour"
#     
#     if Request.error_check(responseobj)
#       puts "Error Code #{responseobj.code}"
#       Resque.enqueue(GetFriends, @user.screen_name)
#     else
#       GetFriends.save_results(responseobj) 
#     end
#   end
#   
#   def self.save_results(responseobj)
#     response = JSON.parse(responseobj.body)
#     response.each do |tweet|
#       ActivistFriend.create(:user_id => @user.user_id, 
#                             :friend_id => friend)
#     end
#     puts "#{response.count} Friends Saved"
#   end
# end