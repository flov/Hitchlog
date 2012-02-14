require 'spec_helper'

describe Trip do
  let(:trip) { Factory.create(:trip) }

  it { should have_many(:rides) }
  it { should belong_to(:user) }
  it { trip.to_s.should == "Tehran &rarr; Shiraz" }

  describe "factories" do
    it "should generate a valid trip" do
      trip.should be_valid
    end
  end

  describe "#kmh" do
    it "returns km/h" do
      trip.distance   = 50_000 # 50 kms
      trip.start      = "07/12/2011 10:00"
      trip.end        = "07/12/2011 13:00" 
      trip.kmh.should == 16
    end
  end

  describe "#to_param" do
    context "has attribute from_city and to_city" do
      it "should output correctly" do
        trip.from_city = 'Cologne'
        trip.to_city = 'Berlin'
        trip.from_city.should == 'Cologne'
        trip.to_param.should == "#{trip.id}-cologne-to-berlin"
      end
    end

    context "has attribute from and to, but not from_city and to_city" do
      it "should output correctly" do
        trip.from = "Berliner Str./B1/B5, Hoppegarten"
        trip.to   = "Warszawa"
        trip.to_param.should == "#{trip.id}-berliner-str-2fb1-2fb5-2c-hoppegarten-to-warszawa"
      end
    end
  end

  describe '#gmaps_difference' do
    context "you were slower than gmaps_difference" do
      it "has a postive gmaps_difference" do
        trip.start = '07/11/2009 10:00'
        trip.end   = '07/11/2009 13:00'
        trip.gmaps_duration = 2.hours.to_i
        trip.gmaps_difference.should == 3600
      end
    end

    context "you were faster than gmaps_difference" do
      it "has a negative gmaps_difference" do
        trip.start = '07/11/2009 10:00'
        trip.end   = '07/11/2009 13:00'
        trip.gmaps_duration = 4.hours.to_i
        trip.gmaps_difference.should == -3600
      end
    end
  end

  describe '#duration' do
    it "should reckon duration with end - start" do
      trip.duration.should == trip.end - trip.start
    end
  end

  describe '#hitchability' do
    context "gmaps_duration is set" do
      it 'reckons hitchability' do
        trip.gmaps_duration = 9.hours.to_f
        trip.start = '07/11/2009 10:00'
        trip.end   = '07/11/2009 20:00'
        trip.hitchability.should == 1.11
      end
    end

    context "gmaps_duration is not set" do
      it 'does not reckon hitchability' do
        trip.gmaps_duration = nil
        trip.start = '07/11/2009 10:00'
        trip.end   = '07/11/2009 20:00'
        trip.hitchability.should == nil
      end
    end
  end

  describe "arrival departure" do
    before do
      trip.start = '07/11/2009 10:00'
      trip.end   = '07/11/2009 20:00'
    end
    it { trip.arrival.should == "07 November 2009 10:00" }
    it { trip.departure.should == "07 November 2009 20:00" }
  end

  describe "not_empty scope" do
    before do
      2.times{|i| trip.rides.build(:number => i+1) }
      @ride = trip.rides.first
      @ride.build_person(:gender => '')
    end

    it "displays rides with waiting time" do
      @ride.waiting_time = 13
      @ride.save!
      trip.rides.not_empty.should == [@ride]
    end
  end

  describe "#experience" do
    context "has only positive experiences" do
      it "returns a positive experience" do
        trip.rides << Factory(:ride, :experience => 'positive')
        trip.overall_experience.should == 'positive'
      end
    end

    context "has a neutral experience" do
      it "returns a neutral experience" do
        trip.rides << Factory( :ride, :experience => 'positive' )
        trip.rides << Factory( :ride, :experience => 'neutral' )
        trip.overall_experience.should == 'neutral'
      end
    end

    context "has a negative experience" do
      it "returns a negative experience" do
        trip.rides << Factory(:ride, :experience => 'positive')
        trip.rides << Factory(:ride, :experience => 'neutral')
        trip.rides << Factory(:ride, :experience => 'negative')
        trip.overall_experience.should == 'negative'
      end
    end
  end
end
