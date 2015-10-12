require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#send_mail" do
    let(:action) { get send_mail_user_path(1) }

    it_blocks_unauthenticated_access
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
      allow(User).to receive_message_chain(:includes, :find_by_username).and_return mail_to_user
      allow(user_mailer).to receive(:deliver_now){ true }
      sign_in current_user
    end

    it 'sends out mail' do
      expect(UserMailer).to receive(:mail_to_user)
        .with(current_user, mail_to_user, 'text')
        .and_return(user_mailer)

      action
    end

    it "redirects to the hitchhikers page" do
      allow(user_mailer).to receive_messages(deliver_now: true)
      allow(UserMailer).to receive(:mail_to_user).and_return(user_mailer)

      action

      expect(response).to redirect_to(user_path(mail_to_user))
    end
  end

  describe '#show' do
    let(:action) { get :show, id: 'flov' }
    let(:user)   { double('user') }
    let(:trip)   { double('trip') }
    let(:search)  { double('meta_where') }

    context 'user cant be found' do
      before do
        get :show, id: 'does not exist'
      end

      xit 'redirects if user cannot be found' do
        expect(response).to redirect_to(root_path)
      end

      xit 'sets the error flash' do
        expect(flash[:error]).to eq('The record was not found')
      end
    end


    xit 'renders show view' do
      allow(User).to receive_message_chain(:includes, :find).and_return user
      allow(user).to receive_message_chain(:trips, :scoped, :order, :search).and_return( search )
      allow(search).to receive_message_chain(:result, :paginate).and_return(trip)

      action

      expect(response).to render_template :show
    end
  end

  describe "#destroy" do
    context "if logged in" do
      let(:current_user) { double('user') }
      let(:another_user) { double('another_user', to_param: 'another_user') }

      before do
        sign_in current_user
      end

      context "signed in user tries to destroy another user" do
        before do
          allow(User).to receive(:find_by_username).and_return(another_user)
          allow(User).to find_current_user
          delete :destroy, id: another_user.to_param
        end

        it "should not delete another user" do
          expect(flash[:alert]).to eq('You are not allowed to do that!')
        end

        it "should redirect to the profile path" do
          expect(response).to redirect_to(user_path(current_user))
        end
      end
    end

    context "if not logged in" do
      it "redirects to log in page" do
        allow(User).to receive_message_chain(:includes, :find_by_username).and_return(double('user'))

        delete :destroy, id: 1

        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe '#geomap' do
    it 'responds with json' do
      get :geomap, id: '1', format: :json

      expect(response.header['Content-Type']).to include 'application/json'
    end
  end
end

private

def find_current_user
  receive_message_chain(:includes, :find_by_username).and_return(current_user)
end
