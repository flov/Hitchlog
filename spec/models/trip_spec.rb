require 'spec_helper'

describe Trip do
  before(:each) do
    @trip = Factory(:trip)
  end

  it { should have_many(:rides) }
  it { should belong_to(:user) }
  it { @trip.to_s.should == "Barcelona &rarr; Madrid" }

  describe "factories" do
    it "should generate a valid trip" do
      @trip.should be_valid
    end
  end

  describe "to_param" do
    it "should output correctly" do
      @trip.from_city = 'Cologne'
      @trip.to_city = 'Berlin'
      @trip.to_param.should == "#{@trip.id}_cologne_to_berlin"
    end

    it "should output correctly" do
      @trip.from = "Berliner Str./B1/B5, Hoppegarten"
      @trip.to   = "Warszawa"
      @trip.to_param.should == "#{@trip.id}_berliner_str__2fb1_2fb5_2c_hoppegarten_to_warszawa"
    end
  end
end
