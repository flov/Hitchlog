require 'spec_helper'

describe SignInAddress do
  it { should belong_to(:user) }
  it "should have valid Factory" do
    Factory.build(:sign_in_address).valid?
  end
end
