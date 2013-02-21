class OmniauthController < ApplicationController
  def create
    access_token = env["omniauth.auth"]
    data         = env["omniauth.auth"]['extra']['raw_info']

    if @user = User.find_by_email(data["email"])
      #found the user using facebook_connect
      if Authentication.find_by_provider_and_uid(access_token['provider'], access_token['uid']).nil?
        # user doesn't use facebook connect yet, so we create an Authentication entry
        @user = User.find_by_email(data["email"])
        @user.authentications.create!(provider: access_token['provider'],
                                      uid: access_token['uid'])
      end
    else # Create a user with a stub password
      @user = User.new(email: data['email'],
                       gender: data['gender'],
                       password: Devise.friendly_token[0,20],
                       username: facebook_username(data)) 
      @user.authentications.build(provider: access_token['provider'],
                                  uid: access_token['uid'])
      @user.save!
    end

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to new_user_registration_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  private

  def facebook_username(hash)
    # A user does not need to have a nickname configured:
    # username: profile.php?id=100002244415511
    if hash['username'].include? '?'
      hash['first_name']
    else
      hash['username'].gsub('.', '_')
    end
  end
end


#<OmniAuth::AuthHash credentials=#<Hashie::Mash expires=true
#expires_at=1366612953
#token="AAAEu9KV9HBUBAGkuut7xArGeFoGgJtjlkYozvjawupT2L3ZAZAMywvHygw5JdfUPXgEOXTRq6KaxJMZAjYKtXYu5fOAIzFrZA4LZAbjvBRAZDZD">
#extra=#<Hashie::Mash raw_info=#<Hashie::Mash email="florian.vallen@gmail.com"
#favorite_teams=[#<Hashie::Mash id="401872513207416" name="Reisegruppe
#Veteran">] first_name="Florian" gender="male" id="1011496368"
#languages=[#<Hashie::Mash id="106059522759137" name="English">, #<Hashie::Mash
#id="105673612800327" name="German">, #<Hashie::Mash id="110343528993409"
#name="Spanish">] last_name="Vallen" link="http://www.facebook.com/fvallen"
#locale="en_US" location=#<Hashie::Mash id="116190411724975" name="Melbourne,
#Victoria, Australia"> name="Florian Vallen" timezone=11
#updated_time="2013-02-06T15:48:14+0000" username="fvallen" verified=true>>
#info=#<OmniAuth::AuthHash::InfoHash email="florian.vallen@gmail.com"
                                    #first_name="Florian"
                                    #image="http://graph.facebook.com/1011496368/picture?type=square"
                          #last_name="Vallen" location="Melbourne, Victoria, Australia" name="Florian
                        #Vallen" nickname="fvallen" urls=#<Hashie::Mash
                        #Facebook="http://www.facebook.com/fvallen"> verified=true> provider="facebook"
#uid="1011496368">

