require 'spec_helper'

describe Trip do
  let(:trip) { FactoryGirl.build(:trip) }

  it { should have_many(:rides) }
  it { should have_many(:comments) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:departure) }
  it { should validate_presence_of(:arrival) }

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

  describe "#arrival_text departure_text" do
    before do
      trip.departure = '07/11/2009 10:00'
      trip.arrival   = '07/11/2009 20:00'
    end
    it { trip.arrival_text.should == "07 November 2009 10:00" }
    it { trip.departure_text.should == "07 November 2009 20:00" }
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
end
