require 'spec_helper'

describe Trip do
  it { should have_many(:rides) }
  it { should belong_to(:user) }

  describe "factories" do
    it "should generate a valid trip" do
      @trip = Factory(:trip)
      @trip.should be_valid
    end
  end

  describe "to_param outputs the correct parameters" do
    before(:each) do
      @trip = Factory(:trip, from: 'Cologne', to: 'Berlin')
    end

    #it do
      #@trip.from_formatted_address = 'Cologne, Germany'
      #@trip.to_formatted_address = 'Berlin, Germany'
      #@trip.to_param.should == "#{@trip.id}_cologne_germany_to_berlin_germany"
    #end

    it do
      @trip.from_city = 'Cologne'
      @trip.to_city = 'Berlin'
      @trip.to_param.should == "#{@trip.id}_cologne_to_berlin"
    end
  end
end
