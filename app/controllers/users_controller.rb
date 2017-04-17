class UsersController < ApplicationController
  expose!(:user) { user_in_context }

  before_action :authenticate_user!, only: [:edit, :mail_sent, :send_mail, :destroy, :update]

  def index
    @search = User.order("id desc").search(params[:q])
    @users = @search.result.paginate(page: params[:page], per_page: 20)
  end

  def show
    @q = user.trips.latest_first.ransack(params[:q])
    @trips = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
  end

  def geomap
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = I18n.t('flash.users.update.notice')
      redirect_to user_path(@user)
    else
      flash[:alert] = I18n.t('flash.users.update.error')
      render action: 'edit'
    end
  end

  def send_mail
  end

  def mail_sent
    mailer = UserMailer.mail_to_user(current_user, user, params[:message_body])
    if mailer.deliver_now
      flash[:success] = I18n.t('flash.users.mail_sent.notice', user: user)
    end
    redirect_to user_path(user)
  end

  def destroy
    user = User.find_by_username(params[:id])
    if user == current_user
      user.destroy
      flash[:success] = t('flash.users.destroy.success')
      redirect_to root_path
    else
      flash[:alert] = t('flash.users.destroy.not_allowed')
      redirect_to user_path(current_user)
    end
  end

  private

  def user_params
    params.require("user").permit(
      :email,
      :password,
      :password_confirmation,
      :remember_me,
      :username,
      :about_you,
      :cs_user,
      :trustroots,
      :be_welcome_user,
      :gender,
      :lat,
      :lng,
      :city,
      :location,
      :country,
      :country_code,
      :origin,
      :languages,
      :date_of_birth
    )
  end

  def user_in_context
    if params[:id]
      user = User.includes(trips: [:rides, :country_distances]).find_by_username(params[:id])
      if user.nil?
        redirect_to root_path, flash: { error: t('general.record_not_found')}
      else
        return user
      end
    else
      User.new(params[:user])
    end

    rescue ActiveRecord::RecordNotFound
  end
end
