require 'spec_helper'

describe Trip do
  before(:each) do
    @trip = Factory.build(:trip)
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

  describe 'gmaps_difference' do
    it "has postive gmaps_difference when you were slower" do
      @trip.start = '07/11/2009 10:00'
      @trip.end   = '07/11/2009 13:00'
      @trip.gmaps_duration = 2.hours.to_i
      @trip.gmaps_difference.should == 3600
    end

    it "has negative gmaps_difference when you were faster" do
      @trip.start = '07/11/2009 10:00'
      @trip.end   = '07/11/2009 13:00'
      @trip.gmaps_duration = 4.hours.to_i
      @trip.gmaps_difference.should == -3600
    end
  end

  describe 'duration' do
    it "should reckon duration with end - start" do
      @trip.duration.should == @trip.end - @trip.start
    end
  end

  describe 'hitchability' do
    it 'reckons hitchability when gmaps_duration is set' do
      @trip.gmaps_duration = 9.hours.to_f
      @trip.start = '07/11/2009 10:00'
      @trip.end   = '07/11/2009 20:00'
      @trip.hitchability.should == 1.11
    end

    it 'does not reckon hitchability when gmaps_duration is not set' do
      @trip.gmaps_duration = nil
      @trip.start = '07/11/2009 10:00'
      @trip.end   = '07/11/2009 20:00'
      @trip.hitchability.should == nil
    end
  end

  describe "arrival departure" do
    before do
      @trip.start = '07/11/2009 10:00'
      @trip.end   = '07/11/2009 20:00'
    end
    it { @trip.arrival.should == "07 November 2009 10:00" }
    it { @trip.departure.should == "07 November 2009 20:00" }
  end

  describe "not_empty scope" do
    before do
      2.times{|i| @trip.rides.build(:number => i+1) }
      @ride = @trip.rides.first
      @ride.build_person(:gender => '')
    end

    it "displays rides with waiting time" do
      @ride.waiting_time = 13
      @ride.save!
      @trip.rides.not_empty.should == [@ride]
    end

    xit "displays rides with gender" do
      @ride.person.gender = 'male'
      @ride.save!
      @trip.rides.not_empty.should == [@ride]
    end
  end
end
