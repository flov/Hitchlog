require 'spec_helper'

describe Trip do
  let(:trip) { FactoryGirl.build(:trip) }

  it { should have_many(:rides) }
  it { should have_many(:comments) }
  it { should belong_to(:user) }

  describe "#valid?" do
    it { should validate_presence_of(:from) }
    it { should validate_presence_of(:to) }
    it { should validate_presence_of(:departure) }
    it { should validate_presence_of(:arrival) }
    it { should validate_presence_of(:travelling_with) }

    describe '#hitchhikes' do
      it { should validate_numericality_of(:hitchhikes) }
      it 'creates 1 ride on trip if hitchhikes equals 1' do
        trip = FactoryGirl.build(:trip, hitchhikes: 1)
        trip.save
        trip.rides.size.should == 1
      end
    end
  end

  describe '#departure and #arrival' do
    it 'should save departure_date and departure_time to departure' do
      trip = FactoryGirl.build(:trip,
                               departure: '5 July, 2013',
                               departure_time: '08:00 AM')

      trip.departure.strftime("%d/%m/%Y %H:%M").should == "05/07/2013 08:00"
    end

    it 'should save arrival_date and arrival_time to arrival' do
      trip = FactoryGirl.build(:trip,
                               arrival: '5 July, 2013',
                               arrival_time: '08:00 AM')

      trip.arrival.strftime("%d/%m/%Y %H:%M").should == "05/07/2013 08:00"
    end
  end

  describe "factories" do
    it "should generate a valid trip" do
      trip.should be_valid
    end
  end

  describe "#kmh" do
    it "returns km/h" do
      trip.distance   = 50_000 # 50 kms
      trip.departure  = "07/12/2011 10:00"
      trip.arrival    = "07/12/2011 13:00" 
      trip.kmh.should == 16
    end
  end

  describe "#to_param" do
    context "has attribute from_city and to_city" do
      it "should output correctly" do
        trip.stub(:id).and_return(123)
        trip.from_city = 'Cologne'
        trip.to_city = 'Berlin'
        trip.to_param.should == "#{trip.id}-cologne-to-berlin"
      end
    end

    context "has attribute from and to, but not from_city and to_city" do
      it "should output correctly" do
        trip.stub(:id).and_return(123)
        trip.from = "Berliner Str./B1/B5, Hoppegarten"
        trip.to   = "Warszawa"
        trip.to_param.should == "#{trip.id}-berliner-str-2fb1-2fb5-2c-hoppegarten-to-warszawa"
      end
    end
  end

  describe '#gmaps_difference' do
    context "if you are slower than gmaps_difference" do
      it "has a postive gmaps_difference" do
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 13:00'
        trip.gmaps_duration = 2.hours.to_i
        trip.gmaps_difference.should == 3600
      end
    end

    context "if you are faster than gmaps_difference" do
      it "has a negative gmaps_difference" do
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 13:00'
        trip.gmaps_duration = 4.hours.to_i
        trip.gmaps_difference.should == -3600
      end
    end
  end

  describe '#duration' do
    it "should reckon duration with arrival - departure" do
      trip.duration.should == trip.arrival - trip.departure
    end
  end

  describe '#hitchability' do
    context "gmaps_duration is set" do
      it 'reckons hitchability' do
        trip.gmaps_duration = 9.hours.to_f
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 20:00'
        trip.hitchability.should == 1.11
      end
    end

    context "gmaps_duration is not set" do
      it 'does not reckon hitchability' do
        trip.gmaps_duration = nil
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 20:00'
        trip.hitchability.should == nil
      end
    end
  end

  describe "#total_waiting_time" do
    it 'returns the total accumulated waiting_time' do
      trip.rides << FactoryGirl.build(:ride, waiting_time: 5)
      trip.rides << FactoryGirl.build(:ride, waiting_time: 6)
      trip.total_waiting_time.should == '11 minutes'
    end

    it 'returns nil if no waiting time has been logged' do
      trip.rides << FactoryGirl.build(:ride, waiting_time: nil)
      trip.total_waiting_time.should == nil
    end
  end

  describe "#experience" do
    context "has only positive experiences" do
      it "returns a positive experience" do
        trip.rides << FactoryGirl.create(:ride, :experience => 'positive')
        trip.overall_experience.should == 'positive'
      end
    end

    context "has a neutral experience" do
      it "returns a neutral experience" do
        trip.rides << FactoryGirl.build_stubbed( :ride, :experience => 'positive' )
        trip.rides << FactoryGirl.build_stubbed( :ride, :experience => 'neutral' )
        trip.overall_experience.should == 'neutral'
      end
    end

    context "has a negative experience" do
      it "returns a negative experience" do
        trip.rides << FactoryGirl.build(:ride, :experience => 'positive')
        trip.rides << FactoryGirl.build(:ride, :experience => 'neutral')
        trip.rides << FactoryGirl.build(:ride, :experience => 'negative')
        trip.overall_experience.should == 'negative'
      end
    end
  end

  describe 'add_ride' do
    it 'adds a ride to the trip' do
      trip.save
      trip.rides.size.should == 1
      trip.add_ride
      trip.rides.size.should == 2
    end
  end
end
