class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :mail_sent, :send_mail, :destroy, :update]

  def show
    @user = User.find(params[:id])
    @rides = @user.trips.map{|trip| trip.rides}.flatten
    @x_times_alone = @user.trips.select {|trip| trip.travelling_with == 0}.size
    @x_times_with_two = @user.trips.select {|trip| trip.travelling_with == 1}.size
    @x_times_with_three = @user.trips.select {|trip| trip.travelling_with == 2}.size
    @x_times_with_four = @user.trips.select {|trip| trip.travelling_with == 3}.size

    @trips = @user.trips
    @trips = build_search_trips(@trips)
    @trips = @trips.order("trips.id DESC").paginate(:page => params[:page])
  end

  def edit

  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t('flash.users.update.notice')
      redirect_to user_path(@user)
    else
      flash[:alert] = I18n.t('flash.users.update.error')
      render :action => 'edit'
    end
  end

  def send_mail
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to user_path(@user)
      flash[:alert] = I18n.t('flash.users.send_mail.error')
    end
  end

  def mail_sent
    @user = User.find(params[:id])
    user_mailer = UserMailer.mail_to_user(current_user, @user, params[:message_body])
    if user_mailer.deliver
      flash[:notice] = I18n.t('flash.users.mail_sent.notice', user: @user)
    end
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      flash[:notice] = t('flash.users.destroy.success')
      redirect_to root_path
    else
      flash[:alert] = t('flash.users.destroy.not_allowed')
      redirect_to user_path(current_user)
    end
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result.order('current_sign_in_at DESC').paginate(:page => params[:page], :per_page => 10)
  end
end
