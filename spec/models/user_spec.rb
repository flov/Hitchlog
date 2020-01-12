require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it { is_expected.to have_many(:trips) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:future_trips) }

  describe 'valid?' do
    describe '#username' do
      it 'allows all these letters: /A-Za-z\d_-/' do
        user.username = 'Abc1239_.'
        expect(user).to be_valid
      end

      it 'converts `.` into `_` for facebook usernames' do
        user.username = 'user.name'
        user.save
        expect(user.username).to eq('user_name')
      end

      it 'downcases the user after validation' do
        user.username = 'AlbertHoffmann'
        user.save
        expect(user.username).to eq('alberthoffmann')
      end

      it 'does not allow these letters:' do
        '#$%?'.each_char do |letter|
          user.username = "username#{letter}"
          expect(user).not_to be_valid
        end
      end
    end
  end

  describe "#location_updated_at" do
    it 'should not change if the location does not change' do
      location_updated_at = user.location_updated_at
      user.save
      expect(user.location_updated_at).to eq(location_updated_at)
    end
  end

  describe "gender" do
    before { user.trips << FactoryBot.build(:trip) }
    it "should display percentage of genders of people who picked you up" do
      user.trips[0].rides << FactoryBot.build(:ride, :gender => 'male')
      user.trips[0].rides << FactoryBot.build(:ride, :gender => 'female')
      user.trips[0].rides << FactoryBot.build(:ride, :gender => 'mixed')
      user.save
      user.genders do
        it { is_expected.to include('male') }
        it { is_expected.to include('female') }
        it { is_expected.to include('mixed') }
      end
      user.genders_in_percentage do
        it { is_expected.to include({'male' => 0.33}) }
        it { is_expected.to include({'female' => 0.33}) }
        it { is_expected.to include({'mixed' => 0.33}) }
      end
    end

    it "only male driver" do
      user.trips[0].rides << FactoryBot.build(:ride, :gender => 'male')
      user.save
      expect(user.genders_in_percentage).to eq({'male' => 1.0})
    end
  end

  describe "hitchhiked kms" do
    it "should return total amount of kms hitchhiked" do
      user.trips << FactoryBot.build(:trip, distance: 1000)
      user.save
      expect(User.last.hitchhiked_kms).to eq(1)
    end
  end

  describe "hitchhiked countries" do
    before do
      trip = FactoryBot.build(:trip,
                               countries: '[["Germany",103060],["Poland",470608]]')
      user.trips << trip
    end

    it "should return number of countries hitchhiked" do
      expect(user.hitchhiked_countries).to eq(2)
    end
  end

  describe "#formatted_address" do
    it "should display the city name and the country if present" do
      user.city = 'Cairns'
      user.country = 'Australia'
      expect(user.formatted_address).to eq('Cairns, Australia')
    end

    it "should display the country name if present" do
      user.city =    'Cairns'
      user.country = nil
      expect(user.formatted_address).to eq('Cairns')
    end

    it "should display the city name if present" do
      user.city = nil
      user.country = 'Australia'
      expect(user.formatted_address).to eq('Australia')
    end

    it "should display `Unknown` if there is no address" do
      user.city = nil
      user.country = nil
      expect(user.formatted_address).to eq('Unknown')
    end
  end

  describe '#to_geomap' do
    before do
      user.trips << FactoryBot.build(:trip, from_city: 'Berlin')
      user.trips << FactoryBot.build(:trip, from_city: 'Madrid')
      2.times { user.trips.first.country_distances.build(country: 'Germany', distance: 1000) }
      1.times { user.trips.last.country_distances.build(country: 'Spain', distance: 1000) }
    end

    it 'should return the json for a google chart DataTable' do
      expect(user.to_geomap).to eq({
        "distances" => {
          "DE" => 2, "ES" => 1
        },
        "trip_count" => { "DE" => 2, "ES" => 1 }
      })
    end
  end

  describe "#vehicles" do
    before do
      user.trips << FactoryBot.build(:trip)
      user.trips[0].rides << FactoryBot.build(:ride, vehicle: 'car')
      user.trips[0].rides << FactoryBot.build(:ride, vehicle: 'car')
      user.trips[0].rides << FactoryBot.build(:ride, vehicle: 'truck')
      user.save
    end

    it 'returns the vehicles that the user has hitchhiked with' do
      expect(user.vehicles).to eq({'car' => 2, 'truck' => 1})
    end
  end

  describe '#average_speed' do
    it 'returns the overall average speed while hitchhiking' do
      user.trips << FactoryBot.build(:trip, distance: 10000, departure: 5.hours.ago, arrival: 4.hours.ago)
      user.trips << FactoryBot.build(:trip, distance: 6000, departure: 5.hours.ago, arrival: 4.hours.ago)

      expect(user.trips.first.average_speed).to eq('10 kmh')
      expect(user.trips.last.average_speed).to  eq('6 kmh')

      expect(user.average_speed).to eq('8 kmh')
    end
  end

  describe '#age' do
    it 'returns the users age' do
      user.date_of_birth = 19.years.ago.to_date
      expect(user.age).to eq(19)
    end
  end

  describe '#age_of_trips' do
    before do
      user.save!
      FactoryBot.create(:trip, departure: 2.years.ago, user_id: user.id,
                                arrival:   2.years.ago + 3.hours)
      FactoryBot.create(:trip, departure: 1.years.ago, user_id: user.id,
                                arrival:   1.years.ago + 3.hours)
      FactoryBot.create(:trip, departure: 3.years.ago,
                                arrival: 3.years.ago + 3.hours,
                                user_id: user.id)
      user.date_of_birth = 23.years.ago.to_date
      user.save!
    end

    it 'returns the number of trips sorted by age' do
      expect(user.age_of_trips).to eq([[20, 1],[21, 1],[22,1]])
    end
  end

  describe '#choose_username' do
    it 'should choose a different username if it already exists' do
      expect(User.choose_username('flo')).to eq('flo')
      FactoryBot.create(:user, username: 'flo')
      expect(User.choose_username('flo')).to eq('flo1')
      FactoryBot.create(:user, username: 'flo1')
      expect(User.choose_username('flo')).to eq('flo2')
    end
  end
end
