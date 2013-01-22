require "spec_helper"

describe FutureTripMailer do
  describe '#nearby_hitchhikers' do
    it "renders template" do
      @user = FactoryGirl.create :user
      @future_trip = FactoryGirl.create :future_trip
      lambda { FutureTripMailer.nearby_hitchhikers(@future_trip, @user) }.should_not raise_error
    end
  end
end
