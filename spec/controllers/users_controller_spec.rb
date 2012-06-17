require 'spec_helper'

describe UsersController do
  describe "GET send_mail" do
    before do
      @to_user = FactoryGirl.create :user
    end

    context "if not logged in" do
      it "should redirect to login page" do
        get :send_mail, :id => @to_user.id
        response.should redirect_to(user_session_path)
      end
    end

    context "if logged in" do
      before do
        @user = FactoryGirl.create :user
        sign_in :user, @user
      end

      context "user sends mail to himself" do
        before do
          get :send_mail, :id => @user.id
        end

        it "should redirect" do
          response.should redirect_to(user_path(@user))
        end

        it "should set the flash" do
          flash[:alert].should eq("You cannot send a mail to yourself")
        end
      end


      it "should render get_mail action" do
        get :send_mail, :id => @to_user.id
        response.should render_template(action: 'get_mail')
      end
    end
  end

  describe "POST mail_sent" do
    before do
      @to_user = FactoryGirl.create :user
    end

    context "if not logged in" do
      it "redirects to log in page" do
        post :mail_sent, id: 1
        response.should redirect_to(user_session_path)
      end
    end

    context "if logged in" do
      before do 
        @user = FactoryGirl.create :user
        sign_in :user, @user
      end

      context "when mail sends successfully" do
        before do
          post :mail_sent, id: @user.id
        end

        it "redirects to the trips index" do
          response.should redirect_to("/en/hitchhikers/#{@user.username}")
        end

        it "sets the flash" do
          flash[:notice].should eq("Mail has been sent to #{@user}")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "if not logged in" do
      it "redirects to log in page" do
        delete :destroy, id: 1
        response.should redirect_to(user_session_path)
      end
    end

    context "if logged in" do
      before do 
        @user = FactoryGirl.create :user
        sign_in :user, @user
      end

      context "signed in user tries to destroy another user" do
        before do
          @another_user = FactoryGirl.create :user
          delete :destroy, id: @another_user.to_param
        end

        it "should not delete another user" do
          flash[:alert].should == 'You are not allowed to do that!'
        end

        it "should redirect to the profile path" do
          response.should redirect_to(user_path(@user))
        end
      end
    end
  end
end
