require 'spec_helper'

describe HitchhikesController, 'routes' do
  it { should route(:get, '/hitchhikes.json').to(:action => 'json') }
end

describe HitchhikesController, 'GET to hitchhikes.json' do
  it "should return valid json" do
    @trip = Factory.create(:trip)
    @hitchhike = Factory.create(:hitchhike)
    get 'json'
    response.should be_success
    json = JSON.parse(response.body)
    puts json
    
    json['from'].should               == @hitchhike.trip.from
    json['to'].should                 == @hitchhike.trip.to
    json['story'].should              == @hitchhike.story
    json['title'].should              == @hitchhike.title
    json['person']['gender'].should   == @hitchhike.person.gender
    json['person']['occupation'].should  == @hitchhike.person.occupation
    json['person']['origin'].should   == @hitchhike.person.origin
    json['person']['name'].should     == @hitchhike.person.name
    json['person']['age'].should      == @hitchhike.person.age
    json['person']['mission'].should  == @hitchhike.person.mission
    json['prev'].should               == @hitchhike.prev
    json['next'].should               == @hitchhike.next 
    json['distance'].should           == @hitchhike.trip.distance 
    json['username'].should           == @hitchhike.trip.user.username
    json['date'].should               == @hitchhike.trip.to_date
    json['photo']['small'].should  == "/images/missingphoto.jpg"
    json['photo']['large'].should  == "/images/missingphoto.jpg"
  end
end