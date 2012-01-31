require 'spec_helper'

describe User do
  it { should have_many(:trips) }
  it { should have_one(:sign_in_address) }
  let(:user) { Factory(:user) }

  describe "experiences" do
    before do
      user.trips << Factory(:trip, :hitchhikes => 0)
    end

    it "should return an array of experiences" do
      user.trips[0].rides << Factory(:ride, :experience => 'positive')
      user.trips[0].rides << Factory(:ride, :experience => 'negative')
      user.trips[0].rides << Factory(:ride, :experience => 'neutral')
      user.experiences.should == ['positive', 'negative', 'neutral']
      user.experiences_in_percentage.should == {'positive' => 0.33, 'neutral' => 0.33, 'negative' => 0.33}
    end

    context "only positive experiences" do
      it do
        2.times{user.trips[0].rides << Factory(:ride, :experience => 'positive')}
        user.experiences_in_percentage.should == {'positive' => 1.0}
      end
    end
  end
  
  describe "hitchhiked kms" do
    it "should return total amount of kms hitchhiked" do
      user.trips << Factory(:trip, :distance => 100_000)
      user.hitchhiked_kms.should == 100
    end
  end

  describe "hitchhiked countries" do
    it "should return number of countries hitchhiked" do
      user.trips << Factory(:trip, :from => "Berlin", :to => "Amsterdam")
      user.hitchhiked_countries.should == 2
    end
  end

  describe "geocode" do
    before do
      @user = Factory(:user, :current_sign_in_ip => "24.193.83.1")
    end

    it "should geocode ip" do
      @user.sign_in_lat.should == 40.728
      @user.sign_in_lng.should == -73.9453
    end

    it "should geocode address" do
      @user.sign_in_address.city.should == "Brooklyn"
      @user.sign_in_address.country.should == "United States"
      @user.sign_in_address.country_code.should == "US"
    end

    it "should change the address when the ip changes" do
      @user.current_sign_in_ip = "85.183.206.162"
      @user.save!
      @user.sign_in_address.city.should == "Hamburg"
    end
  end
end
