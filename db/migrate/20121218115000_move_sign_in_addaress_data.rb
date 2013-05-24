class SignInAddress < ActiveRecord::Base
  belongs_to :user
end

class MoveSignInAddaressData < ActiveRecord::Migration
  def up
  end

  def down
  end
end
