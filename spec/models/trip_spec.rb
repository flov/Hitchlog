require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { FactoryBot.build(:trip) }

  it { is_expected.to have_many(:rides) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:user) }

  describe "#valid?" do
    it { is_expected.to validate_presence_of(:from) }
    it { is_expected.to validate_presence_of(:to) }
    it { is_expected.to validate_presence_of(:departure) }
    it { is_expected.to validate_presence_of(:arrival) }
    it { is_expected.to validate_presence_of(:travelling_with) }

    describe '#hitchhikes' do
      it 'creates 1 ride on trip if hitchhikes equals 1' do
        user = FactoryBot.create(:user)
        trip = FactoryBot.create(:trip, hitchhikes: 1, user_id: user.id)
        expect(trip.rides.size).to eq(1)
      end
    end
  end

  describe '#departure and #arrival' do
    it 'should save departure_date and departure_time to departure' do
      trip = FactoryBot.build(:trip,
                               departure: '5 July, 2013',
                               departure_time: '08:00 AM')

      expect(trip.departure.strftime("%d/%m/%Y %H:%M")).to eq("05/07/2013 08:00")
    end

    it 'should save arrival_date and arrival_time to arrival' do
      trip = FactoryBot.build(:trip,
                               arrival: '5 July, 2013',
                               arrival_time: '08:00 AM')

      expect(trip.arrival.strftime("%d/%m/%Y %H:%M")).to eq("05/07/2013 08:00")
    end
  end

  describe "factories" do
    it "should generate a valid trip" do
      expect(trip).to be_valid
    end
  end

  describe "#kmh" do
    it "returns km/h" do
      trip.distance   = 50_000 # 50 kms
      trip.departure  = "07/12/2011 10:00"
      trip.arrival    = "07/12/2011 13:00" 
      expect(trip.kmh).to eq(16)
    end
  end

  describe "#to_param" do
    context "has attribute from_city and to_city" do
      it "should output correctly" do
        allow(trip).to receive(:id).and_return(123)
        trip.from_city = 'Cologne'
        trip.to_city = 'Berlin'
        expect(trip.to_param).to eq("#{trip.id}-cologne-to-berlin")
      end
    end

    context "has attribute from and to, but not from_city and to_city" do
      it "should output correctly" do
        allow(trip).to receive(:id).and_return(123)
        trip.from = "Berliner Str./B1/B5, Hoppegarten"
        trip.to   = "Warszawa"
        expect(trip.to_param).to eq("#{trip.id}-berliner-str-2fb1-2fb5-2c-hoppegarten-to-warszawa")
      end
    end
  end

  describe '#gmaps_difference' do
    context "if you are slower than gmaps_difference" do
      it "has a postive gmaps_difference" do
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 13:00'
        trip.gmaps_duration = 2.hours.to_i
        expect(trip.gmaps_difference).to eq(3600)
      end
    end

    context "if you are faster than gmaps_difference" do
      it "has a negative gmaps_difference" do
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 13:00'
        trip.gmaps_duration = 4.hours.to_i
        expect(trip.gmaps_difference).to eq(-3600)
      end
    end
  end

  describe '#duration' do
    it "should reckon duration with arrival - departure" do
      expect(trip.duration).to eq(trip.arrival - trip.departure)
    end
  end

  describe '#hitchability' do
    context "gmaps_duration is set" do
      it 'reckons hitchability' do
        trip.gmaps_duration = 9.hours.to_f
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 20:00'
        expect(trip.hitchability).to eq(1.11)
      end
    end

    context "gmaps_duration is not set" do
      it 'does not reckon hitchability' do
        trip.gmaps_duration = nil
        trip.departure = '07/11/2009 10:00'
        trip.arrival   = '07/11/2009 20:00'
        expect(trip.hitchability).to eq(nil)
      end
    end
  end

  describe "#total_waiting_time" do
    it 'returns the total accumulated waiting_time' do
      trip.rides << FactoryBot.build(:ride, waiting_time: 5)
      trip.rides << FactoryBot.build(:ride, waiting_time: 6)
      expect(trip.total_waiting_time).to eq('11 minutes')
    end

    it 'returns nil if no waiting time has been logged' do
      trip.rides << FactoryBot.build(:ride, waiting_time: nil)
      expect(trip.total_waiting_time).to eq(nil)
    end
  end

  describe "#overall_experience" do
    context "has only good experiences" do
      it "returns a good experience" do
        trip.rides << FactoryBot.create(:ride, :experience => 'good')
        expect(trip.overall_experience).to eq('good')
      end
    end

    context "has a neutral experience" do
      it "returns a neutral experience" do
        trip.rides << FactoryBot.build_stubbed( :ride, :experience => 'good' )
        trip.rides << FactoryBot.build_stubbed( :ride, :experience => 'neutral' )
        expect(trip.overall_experience).to eq('neutral')
      end
    end

    context "has a bad experience" do
      it "returns a bad experience" do
        trip.rides << FactoryBot.build(:ride, :experience => 'good')
        trip.rides << FactoryBot.build(:ride, :experience => 'neutral')
        trip.rides << FactoryBot.build(:ride, :experience => 'bad')
        expect(trip.overall_experience).to eq('bad')
      end
    end

    context "has a bad and a very good experience" do
      it "returns a bad experience" do
        trip.rides << FactoryBot.build(:ride, :experience => 'very good')
        trip.rides << FactoryBot.build(:ride, :experience => 'bad')
        expect(trip.overall_experience).to eq('bad')
      end
    end
  end

  describe 'add_ride' do
    it 'adds a ride to the trip' do
      trip.save
      expect(trip.rides.size).to eq(1)
      trip.add_ride
      expect(trip.rides.size).to eq(2)
    end
  end

  describe '#age' do
    it 'displays the age of the hitchhiker at the time the trip was done' do
      trip.user.date_of_birth = 20.year.ago.to_date
      trip.departure = ( 1.year.ago - 200.days ).to_datetime
      expect(trip.age).to eq(18)
    end
  end

  describe '#average_speed' do
    it 'returns the average speed' do
      trip.distance = 5000 # meters
      allow(trip).to receive_messages(duration: 1.hour.to_i)
      expect(trip.average_speed).to eq('5 kmh')
    end
  end

  describe 'countries=' do
    it 'converts the string to an array and sets the country distances' do
      trip.countries = '[["Netherlands",116566],["Belgium",86072]]'
      expect(trip.country_distances.size).to eq(2)
      expect(trip.country_distances.first.distance).to eq(116566)
      expect(trip.country_distances.last.distance).to eq(86072)
    end
  end

  describe '#to_firebase_document' do
    it 'returns a hash with the trip data' do
      expect(trip.to_firebase_document).to eq({
        id: trip.id,
        uid: trip.user_id,
        arrival: trip.arrival,
        departure: trip.departure,
        origin: {
          lat: trip.from_lat,
          lng: trip.from_lng,
          city: trip.from_city,
          country: trip.from_country,
          countryCode: trip.from_country_code,
        },
        destination: {
          lat: trip.to_lat,
          lng: trip.to_lng,
          city: trip.to_city,
          country: trip.to_country,
          countryCode: trip.to_country_code,
        },
        googleDuration: trip.gmaps_duration,
        totalDistance: trip.distance,
        rides: trip.rides.map(&:to_firebase_document),
        createdAt: trip.created_at,
        updatedAt: trip.updated_at,
      })
    end
  end
end
