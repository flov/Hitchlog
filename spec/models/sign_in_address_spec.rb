require 'spec_helper'

describe SignInAddress do
  it { should belong_to(:user) }
  it "should have valid Factory" do
    FactoryGirl.build(:sign_in_address).valid?
  end

  it "should sanitize country and city" do
    sign_in_address = FactoryGirl.create(:sign_in_address)
    sign_in_address.country = "Belgium"
    sign_in_address.to_s.should == "Belgium"

    sign_in_address.city = "Brussels"
    sign_in_address.to_s.should == "Brussels, Belgium"

  end
end
