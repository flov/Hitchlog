class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]
  
  def show
    @user = User.find(params[:id])
    @trips = @user.trips.paginate(:page => params[:page], :per_page => 20)

    get_user_settings(@user)
  end
  
  def edit
    @trips = current_user.trips
  end
  
  def index
    @users = User.order('users.username ASC').all
  end
end
