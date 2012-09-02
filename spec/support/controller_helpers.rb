module ControllerHelpers
  def self.included(base)
    base.instance_eval do
      extend ControllerHelpers::ClassMethods
    end
  end

  def sign_in(scope = double('devise'), object = double('devise'))
    if scope.nil? || scope.is_a?(RSpec::Mocks::Mock)
      scope, object = :user, scope
    end

    if object.nil?
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, {:scope => scope})
      controller.stub "current_#{scope}" => nil
    else
      request.env['warden'].stub :authenticate! => object
      controller.stub "current_#{scope}" => object
    end
  end

  module ClassMethods
    def it_blocks_unauthenticated_access
      it "blocks unauthenticated access" do
        sign_in nil

        action

        response.should redirect_to(new_user_session_path)
      end
    end
  end
end
