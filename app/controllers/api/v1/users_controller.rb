module Api
  module V1
    class UsersController < Api::V1::BaseController
      #before_action :authenticate_user!, only: [:edit, :destroy, :update]
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.paginate(page: params[:page])
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { message: @user.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: { message: "Couldn't find User" }, status: :not_found if !@user
      end

      def update
        @user.update_attributes(user_params)
        head :no_content
      end

      def destroy
        @user.destroy
        head :no_content
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

      def set_user
        @user = User.find_by_username(params[:id])
      end
    end
  end
end
