class User
  def self.find_for_facebook_oauth(access_token)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      #found the user using facebook_connect
      if Authentication.find_by_provider_and_uid(access_token['provider'], access_token['uid']).nil?
        # user doesn't use facebook connect yet, so we create an Authentication entry
        user = User.find_by_email(data["email"])
        user.authentications.create!(:provider => access_token['provider'],
                                     :uid => access_token['uid'])
      end
    else # Create a user with a stub password. 
      user = User.new(:email => data['email'],
                      :gender => data['gender'],
                      :password => Devise.friendly_token[0,20],
                      :username => self.facebook_username(access_token['user_info'])) 
      user.authentications.build(:provider => access_token['provider'],
                                 :uid => access_token['uid'])
      user.save!
    end
    user
  end 

  def self.facebook_username(user_info)
    # A user does not need to have a nickname configured:
    # nickname: profile.php?id=100002244415511
    if user_info['nickname'].nil? or user_info['nickname'].include? '?'
      user_info['first_name']
    else
      user_info['nickname']
    end
  end
end

# {"provider"=>"facebook", "uid"=>"100002089022176",
#   "credentials"=>{"token"=>"AAAEu9KV9HBUBAA2ZAxJwKXGOt70IJR6HqMNi3nvWgscBuq8VTX6Eiw0GvrUMmjpC1nEghkNY0ClZAVJ6j2dqT4yNcGIvrebqL2hO2PHgZDZD"},
#   "user_info"=>{
#     "nickname"=>nil,
#     "email"=>"jesus@example.com",
#     "first_name"=>"Jesus",
#     "last_name"=>"Garcia",
#     "name"=>"Jesus Garcia",
#     "image"=>"http://graph.facebook.com/100002089022176/picture?type=square",
#     "urls"=>{
#       "Facebook"=>"http://www.facebook.com/profile.php?id=100002089022176",
#       "Website"=>nil
#     }
#   },
#   "extra"=>{
#     "user_hash"=>{
#     "id"=>"100002089022176",
#       "name"=>"Jesus Garcia", "first_name"=>"Jesus", "last_name"=>"Garcia",
#       "link"=>"http://www.facebook.com/profile.php?id=100002089022176",
#       "gender"=>"male", "email"=>"jesus@example.com", "timezone"=>5.5,
#       "locale"=>"en_US", "updated_time"=>"2011-02-10T16:13:54+0000"}}}
