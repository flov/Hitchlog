class OmniauthController < ApplicationController
  def create
    access_token = env["omniauth.auth"]
    data         = env["omniauth.auth"]['extra']['raw_info']

    if @user = User.find_by_email(data["email"])
      #found the user using facebook_connect
      if Authentication.find_by_provider_and_uid(access_token['provider'], access_token['uid']).nil?
        # user doesn't use facebook connect yet, so we create an Authentication entry
        @user.authentications.create!(provider: access_token['provider'],
                                      uid: access_token['uid'])
      end

      if @user.date_of_birth.nil?
        @user.update_column(:date_of_birth, Date.strptime(data['birthday'], '%m/%d/%Y'))
      end

      if @user.languages.nil?
        @user.update_column(:languages, data['languages'].map(&:name).join(', '))
      end
    else # Create a user with a generated password
      @user = User.new(email: data['email'],
                       gender: data['gender'],
                       password: Devise.friendly_token[0,20],
                       date_of_birth: Date.strptime(data['birthday'], '%m/%d/%Y'),
                       username: facebook_username(data)) 
      @user.authentications.build(provider: access_token['provider'],
                                  uid: access_token['uid'])
      @user.save!
    end

    if @user.persisted?
      flash[:success] = I18n.t('devise.sessions.signed_in')
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to new_user_registration_url
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:success] = "Successfully removed authentication."
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

