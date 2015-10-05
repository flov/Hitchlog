module ControllerHelpers
  def self.included(base)
    base.instance_eval do
      extend ControllerHelpers::ClassMethods
    end
  end

  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  module ClassMethods
    def it_blocks_unauthenticated_access
      it "blocks unauthenticated access" do
        sign_in nil

        action

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    def it_blocks_access_for_different_owner
      it "blocks access for different user than owner" do
        sign_in :user

        action

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
