require 'spec_helper'

describe User, 'valid' do
  it { should have_many(:trips) }

  describe "hitchhiked kms" do
    it "should return total amount of kms hitchhiked" do
      @user = Factory(:user)
      @user.trips << Factory(:trip, :distance => 100_000)
      @user.hitchhiked_kms.should == 100
    end
  end

  describe "hitchhiked countries" do
    it "should return number of countries hitchhiked" do
      @user = Factory(:user)
      @user.trips << Factory(:trip, :from => "Berlin", :to => "Amsterdam")
      @user.hitchhiked_countries.should == 2
    end
  end
end
