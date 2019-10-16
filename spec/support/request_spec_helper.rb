module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

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
