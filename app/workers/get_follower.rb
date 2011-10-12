# class GetFollower
#   
#   @queue = :Monitor_mentions
#   
#   URL = "twitter-blake41.apigee.com/1/users/lookup.json"
# 
#   def self.perform(array)
#     followers = Helpers.prepare_array(array)
#     responseobj = Request.get(URL, {:user_id => followers })
#     if Request.error_check(responseobj)
#       Resque.enqueue(GetFollower, array)
#     else
#       GetFollower.store(responseobj)
#     end
#   end
#   
#   def self.store(responseobj)
#     response = JSON.parse(responseobj.body)
#     response.each do |user|
#       follower = GillibrandFollower.where(:user_id => user['id'])
#       follower[0].update_attributes(:follower_count => user['followers_count'], 
#                                     :screen_name => user['screen_name'], 
#                                     :description => user['description'], 
#                                     :location => user['location'])
#     end
#   end
# end