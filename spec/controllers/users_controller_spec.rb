require 'spec_helper'

describe UsersController do
  describe "#send_mail" do
    let(:action) { get :send_mail, :id => 1 }

    it_blocks_unauthenticated_access

    it "renders get_mail template" do
      sign_in :user, double('user')
      response.should render_template(action: 'get_mail')
    end
  end

  describe "#mail_sent" do
    let(:action) { post :mail_sent, id: 'flov', message_body: 'text' }
    let(:current_user) { double('user1',
                                username: 'flov',
                                to_param: 'flov',
                                email: 'flov@hitchlog.com') }
    let(:mail_to_user) { double('user2',
                                'attributes=' => '',
                                username: 'Malte',
                                to_param: 'malte',
                                email: 'malte@tramprennen.org') }
    let(:user_mailer) { double('UserMailer') }

    it_blocks_unauthenticated_access

    before do
      sign_in :user, current_user
      User.stub(:find).and_return(mail_to_user)
      user_mailer.stub(:deliver){ true }
    end

    it 'sends out mail' do
      UserMailer.should_receive(:mail_to_user)
        .with(current_user, mail_to_user, 'text')
        .and_return(user_mailer)

      action
    end

    it "redirects to the hitchhikers page" do
      user_mailer.stub(deliver: true)
      UserMailer.stub(:mail_to_user).and_return(user_mailer)

      action

      response.should redirect_to(user_path(mail_to_user))
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
      let(:current_user) { double('user') }
      let(:another_user) { double('another_user', to_param: 'another_user') }

      before do 
        sign_in :user, current_user
      end

      context "signed in user tries to destroy another user" do
        before do
          User.stub(:find).and_return(another_user)
          delete :destroy, id: another_user.to_param
        end

        it "should not delete another user" do
          flash[:alert].should == 'You are not allowed to do that!'
        end

        it "should redirect to the profile path" do
          response.should redirect_to(user_path(current_user))
        end
      end
    end
  end
end
