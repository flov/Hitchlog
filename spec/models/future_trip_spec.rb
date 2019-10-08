require 'rails_helper'

RSpec.describe FutureTrip, type: :model do

  let(:future_trip) { FactoryBot.build(:future_trip) }

  it { is_expected.to belong_to(:user) }

  describe "#valid?" do
    it { is_expected.to validate_presence_of(:from) }
    it { is_expected.to validate_presence_of(:to) }
    it { is_expected.to validate_presence_of(:departure) }

    describe '#departure' do
      it "cannot be in the past" do
        future_trip = FutureTrip.new(departure: 2.days.ago)
        expect(future_trip).to have(1).error_on(:departure)
      end

      it "can be in the future" do
        future_trip.departure = 1.day.from_now
        expect(future_trip).to have(0).error_on(:departure)
      end
    end
  end

  describe '#to_s' do
    it "outputs correct string" do
      future_trip.from_city = 'Hamburg'
      future_trip.to_city = 'Duisburg'

      expect(future_trip.to_s).to eq('Hamburg &rarr; Duisburg')
    end
  end

  describe '#formatted_departure' do
    it 'formats the time' do
      time = 1.day.from_now
      future_trip.departure = time
      expect(future_trip.formatted_departure).to eq(future_trip.departure.strftime("%d %b %Y"))
    end
  end

  describe '#formatted_from' do
    it 'displays city and country if present' do
      future_trip.from_country = 'Spain'
      future_trip.from_city = 'Barcelona'
      expect(future_trip.formatted_from).to eq("Barcelona, Spain")
    end

    it 'displays city if present and country is not' do
      future_trip.from_city = 'Barcelona'
      expect(future_trip.formatted_from).to eq("Barcelona")
    end

    it 'displays from if from_city is not present' do
      future_trip.from_city = nil
      future_trip.from_country = nil
      future_trip.from = "Manchester"
      expect(future_trip.formatted_from).to eq("Manchester")
    end
  end

  describe '#formatted_from' do
    it 'displays city if present' do
      future_trip.to_city = 'Madrid'
      expect(future_trip.formatted_to).to eq("Madrid")
    end

    it 'displays from if from_city is not present' do
      future_trip.to_city = nil
      future_trip.to = "Madrid"
      expect(future_trip.formatted_to).to eq("Madrid")
    end
  end
end
