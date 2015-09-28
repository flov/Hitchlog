require "rails_helper"

RSpec.describe UserMailer do
  describe '#nearby_hitchhikers' do
    it "renders template" do
      @user = FactoryGirl.create :user
      @future_trip = FactoryGirl.create :future_trip
      expect { FutureTripMailer.nearby_hitchhikers(@future_trip, @user) }.not_to raise_error
    end
  end
end
