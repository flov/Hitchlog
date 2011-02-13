require 'spec_helper'

describe HitchhikesController, 'routes' do
  it { should route(:get, '/hitchhikes.json').to(:action => 'json') }
  puts Rails.env
end

describe HitchhikesController, 'GET to hitchhikes.json' do
  before do
    @trip = Factory.create(:trip)
    2.times {Factory.create(:hitchhike)}
    @hitchhike = Factory :hitchhike
  end

  it "should return valid json" do
    get 'json'
    response.should be_success
    json = JSON.parse(response.body)

    json['from'].should               == @hitchhike.trip.from
    json['to'].should                 == @hitchhike.trip.to
    json['story'].should              == @hitchhike.story
    json['rides'].should              == Hitchhike.where(:trip_id => @hitchhike.trip_id).size
    json['title'].should              == @hitchhike.title
    json['person']['gender'].should   == @hitchhike.person.gender
    json['person']['occupation'].should  == @hitchhike.person.occupation
    json['person']['origin'].should   == @hitchhike.person.origin
    json['person']['name'].should     == @hitchhike.person.name
    json['person']['age'].should      == @hitchhike.person.age
    json['person']['mission'].should  == @hitchhike.person.mission
    #json['prev'].should               == "/hitchhikes/#{@hitchhike.prev.to_param}"
    #json['next'].should               == "/hitchhikes/#{@hitchhike.next.to_param}"
    json['distance'].should           == @hitchhike.trip.distance 
    json['username'].should           == @hitchhike.trip.user.username
    json['date'].should               == @hitchhike.trip.to_date
    json['photo']['small'].should     == "/images/missingphoto.jpg"
    json['photo']['large'].should     == "/images/missingphoto.jpg"
  end
end
