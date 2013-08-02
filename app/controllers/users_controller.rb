class UsersController < ApplicationController
  expose!(:user) { user_in_context }
  expose(:users) { User.order('current_sign_in_at DESC').paginate(page: params[:page], per_page: 20) }
  expose(:trips) { trips_in_context }

  before_filter :authenticate_user!, only: [:edit, :mail_sent, :send_mail, :destroy, :update]

  def show
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = I18n.t('flash.users.update.notice')
      redirect_to user_path(@user)
    else
      flash[:alert] = I18n.t('flash.users.update.error')
      render action: 'edit'
    end
  end

  def mail_sent
    mailer = UserMailer.mail_to_user(current_user, user, params[:message_body])
    if mailer.deliver
      flash[:success] = I18n.t('flash.users.mail_sent.notice', user: user)
    end
    redirect_to user_path(user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      flash[:success] = t('flash.users.destroy.success')
      redirect_to root_path
    else
      flash[:alert] = t('flash.users.destroy.not_allowed')
      redirect_to user_path(current_user)
    end
  end

  def geomap
  end

  private

  def user_in_context
    if params[:id]
      User.includes(trips: [:rides, :country_distances]).find(params[:id])
    else
      User.new(params[:user])
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: t('general.record_not_found')}
  end

  def trips_in_context
    user.trips.paginate(page: params[:page], per_page: 5)  

    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { error: t('general.record_not_found')}
  end
end
