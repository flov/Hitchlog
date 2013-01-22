require 'spec_helper'

describe FutureTrip do

  let(:future_trip) { FactoryGirl.build(:future_trip) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:departure) }

  describe '#to_s' do
    it "outputs correct string" do
      future_trip.from_city = 'Hamburg'
      future_trip.to_city = 'Duisburg'

      future_trip.to_s.should == 'Hamburg &rarr; Duisburg'
    end
  end

  describe '#formatted_time' do
    it 'formats the time' do
      time = 1.day.from_now
      future_trip.departure = time
      future_trip.formatted_time.should == "#{time.day} #{time.strftime("%b")} #{time.year}"
    end
  end

  describe '#formatted_from' do
    it 'displays city and country if present' do
      future_trip.from_country = 'Spain'
      future_trip.from_city = 'Barcelona'
      future_trip.formatted_from.should == "Barcelona, Spain"
    end

    it 'displays city if present and country is not' do
      future_trip.from_city = 'Barcelona'
      future_trip.formatted_from.should == "Barcelona"
    end

    it 'displays from if from_city is not present' do
      future_trip.from_city = nil
      future_trip.from_country = nil
      future_trip.from = "Manchester"
      future_trip.formatted_from.should == "Manchester"
    end
  end

  describe '#formatted_from' do
    it 'displays city if present' do
      future_trip.to_city = 'Madrid'
      future_trip.formatted_to.should == "Madrid"
    end

    it 'displays from if from_city is not present' do
      future_trip.to_city = nil
      future_trip.to = "Madrid"
      future_trip.formatted_to.should == "Madrid"
    end
  end
end
