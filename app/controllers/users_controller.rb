class UsersController < ApplicationController
  expose!(:user) { user_in_context }

  before_action :authenticate_user!, only: [:edit, :mail_sent, :send_mail, :destroy, :update]

  def index
    @search = User.order("id desc").search(params[:q])
    @users = @search.result.paginate(page: params[:page], per_page: 20)
  end

  def show
    @trips = user.trips.latest_first.paginate(page: params[:page])
    #@search = user.trips.scoped.order("id desc").search(params[:q])
    #@trips = @search.result(distinct: true).paginate(page: params[:page], per_page: 20)
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
    if mailer.deliver
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
      User.includes(trips: [:rides, :country_distances]).find_by_username(params[:id])
    else
      User.new(params[:user])
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: t('general.record_not_found')}
  end
end
