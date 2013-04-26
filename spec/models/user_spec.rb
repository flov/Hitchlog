require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it { should have_many(:trips) }
  it { should have_many(:comments) }
  it { should have_many(:authentications) }
  it { should have_many(:future_trips) }

  before do
    user.trips << FactoryGirl.build(:trip)
  end

  describe 'valid?' do
    describe 'validates usernae' do
      it 'allows all those letters: /A-Za-z\d_-/' do
        user.username = 'Abc1239_-'
        user.should be_valid
      end

      it 'does not allow other letters:' do
        user.username = '#$%?'
        user.should_not be_valid
      end
    end
  end

  describe "#location_updated_at" do
    it 'should not change if the location does not change' do
      user.save!
      location_updated_at = user.location_updated_at
      user.save!
      user.location_updated_at.should == location_updated_at
    end

  end

  describe "#facebook_user" do
    it 'should test if the user has authenticated via facebook' do
      user.authentications = []
      user.facebook_user?.should be_false

      user.authentications.build(provider: 'facebook', uid: 1011496368)
      user.save!
      user.facebook_user?.should be_true
    end
  end

  describe "experiences" do
    context "unequal number of experiences" do
      it "should return an array of experiences" do
        user.trips[0].rides << FactoryGirl.build(:ride, :experience => 'positive')
        user.trips[0].rides << FactoryGirl.build(:ride, :experience => 'negative')
        user.trips[0].rides << FactoryGirl.build(:ride, :experience => 'neutral')
        user.experiences.should == ['positive', 'negative', 'neutral']
        user.experiences_in_percentage.should == {'positive' => 0.33, 'neutral' => 0.33, 'negative' => 0.33}
      end
    end

    context "only positive experiences" do
      it do
        user.trips[0].rides << FactoryGirl.build(:ride, :experience => 'positive')
        user.experiences_in_percentage.should == {'positive' => 1.0}
      end
    end
  end

  describe "gender" do 
    it "should display percentage of genders of people who picked you up" do
      user.trips[0].rides << FactoryGirl.build(:ride, :gender => 'male')
      user.trips[0].rides << FactoryGirl.build(:ride, :gender => 'female')
      user.trips[0].rides << FactoryGirl.build(:ride, :gender => 'mixed')
      user.genders.should == ['male', 'female', 'mixed']
      user.genders_in_percentage.should == {'male' => 0.33, 'female' => 0.33, 'mixed' => 0.33}
    end

    it "only male driver" do
      user.trips[0].rides << FactoryGirl.build(:ride, :gender => 'male')
      user.genders_in_percentage.should == {'male' => 1.0}
    end
  end

  describe "hitchhiked kms" do
    it "should return total amount of kms hitchhiked" do
      user.trips.first.distance = 100_000
      user.hitchhiked_kms.should == 100
    end
  end

  describe "hitchhiked countries" do
    it "should return number of countries hitchhiked" do
      user.trips.first.from = "Berlin"
      user.trips.first.to   = "Amsterdam"
      VCR.use_cassette('hitchhiked_countries') do
        user.save!
      end
      user.hitchhiked_countries.should == 2
    end
  end

  describe "geocode" do
    before do
      VCR.use_cassette('brooklyn_ip_address') do
        user.current_sign_in_ip = "24.193.83.1"
        user.save!
      end
    end

    it "should geocode lat and lng from ip" do
      user.lat.should == 40.728
      user.lng.should == -73.9453
    end

    it "should geocode address" do
      user.country_code.should == "US"
      user.city.should == "Brooklyn"
      user.country.should == "United States"
    end
  end

  describe "#formatted_address" do
    it "should display the city name and the country if present" do
      user.city = 'Cairns'
      user.country = 'Australia'
      user.formatted_address.should == 'Cairns, Australia'
    end

    it "should display the country name if present" do
      user.city =    'Cairns'
      user.country = nil
      user.formatted_address.should == 'Cairns'
    end

    it "should display the city name if present" do
      user.city = nil
      user.country = 'Australia'
      user.formatted_address.should == 'Australia'
    end

    it "should display `Unknown` if there is no address" do
      user.city = nil
      user.country = nil
      user.formatted_address.should == 'Unknown'
    end
  end
end
