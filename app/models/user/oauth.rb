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
      user = User.new(:email => data["email"],
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
    if user_info['nickname'].include? '?'
      user_info['first_name']
    else
      user_info['nickname']
    end
  end
end

## Example Data returned from facebook:
#--- 
#provider: facebook
#uid: "100002244415511"
#credentials: 
  #token: 133141056704542|56b0473a54317c16f42188cf-100002244415511|XlkdyCu1k_rl-m6MWqNfJZbqLeg
#user_info: 
  #nickname: profile.php?id=100002244415511
  #email: florian@example.com
  #first_name: Klaus
  #last_name: Taler
  #name: Klaus Taler
  #image: http://graph.facebook.com/100002244415511/picture?type=square
  #urls: 
    #Facebook: http://www.facebook.com/profile.php?id=100002244415511
    #Website: 
#extra: 
  #user_hash: 
    #id: "100002244415511"
    #name: Klaus Taler
    #first_name: Klaus
    #last_name: Taler
    #link: http://www.facebook.com/profile.php?id=100002244415511
    #gender: male
    #email: florian@example.com
    #timezone: 2
    #locale: en_US
    #updated_time: 2011-04-09T13:54:55+0000


