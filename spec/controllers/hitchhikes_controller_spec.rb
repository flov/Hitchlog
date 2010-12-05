require 'spec_helper'

describe HitchhikesController, 'routes' do
  it { should route(:get, '/hitchhikes').to(:action => 'index') }
end

describe HitchhikesController, 'GET to hitchhikes.json' do
  it "should return valid json" do
    @trip = Factory.create(:trip)
    get '/hitchhikes.json'
    response.should be_success
    json = JSON.parse(response.body)
    json['from'].should    == @trip.from
    json['to'].should      == @trip.to
    # json['from']['city'].should    == @hitchhike.from_city
    # json['from']['country'].should == @hitchhike.from_country
    # json['to']['city'].should      == @hitchhike.from_city
    # json['to']['country'].should   == @hitchhike.from_country
    # json['distance'].should        == @hitchhike.distance
    # json['photo']['small'].should  == "/images/missingphoto.jpg"
    # json['photo']['large'].should  == "/images/missingphoto.jpg"
  end
end
