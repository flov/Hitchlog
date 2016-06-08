require 'rails_helper'

RSpec.describe DataPresenter do
  describe '#trip_data_for_map' do
    before do
      trip = FactoryGirl.build(:trip, hitchhikes: 0)
      trip.rides.build(experience: 'very good', vehicle: "car")
      trip.rides.build(experience: 'good', vehicle: "plane")
      trip.rides.build(experience: 'bad', vehicle: "bus",
                      photo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'thumb.png')))
      trip.country_distances.build(country: 'Germany', country_code: "DE", distance: 3000)
      trip.save!
      trip_2 = FactoryGirl.build(:trip, hitchhikes: 0)
      trip_2.rides.build(experience: 'very bad', vehicle: "boat", story: "this is a true tale...")
      trip_2.rides.build(experience: 'bad', vehicle: "truck")
      trip_2.country_distances.build(country: 'Spain', country_code: "ES", distance: 3000)
      trip_2.save!
      trip_3 = FactoryGirl.build(:trip, hitchhikes: 0)
      trip_3.rides.build(experience: 'neutral', vehicle: "motorcycle")
      trip_3.country_distances.build(country: 'Poland', country_code: "PL", distance: 3000)
      trip_3.save!
    end

    it 'should return the json for a google chart DataTable' do
      expect(DataPresenter.new.trip_data_for_map).to eq({
        "trips_count" => { "DE" => 3, "PL" => 1, "ES" => 2},
        "stories" => {"ES"=>1},
        "photos" => {"DE"=>1},

        "very_good" => { "DE" => 1 },
        "good" => { "DE" => 1 },
        "total_good" => { "DE" => 2 },
        "bad_ratio" => {"DE"=>33, "ES"=>100},
        "good_ratio" => { "DE" =>67 },
        "neutral" => { "PL" => 1 },
        "bad" => { "DE" => 1, "ES" => 1},
        "very_bad" => { "ES" => 1 },
        "total_bad" => { "DE" => 1, "ES" => 2 },

        "rides_with_vehicle" => {"DE"=>3, "ES"=>2, "PL"=>1},

        "car"=>{"DE"=>1},
        "car_ratio" => {"DE"=>33},
        "bus"=>{"DE"=>1},
        "bus_ratio" => {"DE"=>33},
        "truck_ratio" => {"ES"=>50},
        "truck"=>{"ES"=>1},
        "motorcycle"=>{"PL"=>1},
        "motorcycle_ratio" => {"PL"=>100},
        "plane"=>{"DE"=>1},
        "plane_ratio" => {"DE"=>33},
        "boat"=>{"ES"=>1},
        "boat_ratio" => {"ES"=>50}

      })
    end
  end

  describe '#trips_count_for_map' do
    before do
      trip = FactoryGirl.build(:trip, hitchhikes: 0)
      trip.country_distances.build(country: 'Germany', country_code: "DE", distance: 3000)
      trip.rides.build(story: "this is a true tale...",
                       photo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'thumb.png')))
      trip.save!
    end

    it 'should return the json for a google chart DataTable' do
      expect(DataPresenter.new.trips_count_for_map).to eq({
        "trips_count" => { "DE" => 1 },
        "photos" => {"DE"=>1},
        "stories" => {"DE"=>1}
      })
    end
  end

  describe '#hitchhikers_with_most_stories' do
    before do
      ["supertramp", "flohfish"].each do |username|
        user = FactoryGirl.build(:user, username: username)
        trip = FactoryGirl.build(:trip, hitchhikes: 0)
        trip.country_distances.build(country: 'Germany', country_code: "DE", distance: 3000)
        trip.rides.build( story: "this is a true tale...")
        user.trips << trip
        user.save
      end
    end

    it 'should return the json for a google chart DataTable' do
      expect(DataPresenter.new.hitchhikers_with_most_stories).to eq(
        [{username: 'flohfish', stories: 1},
         {username: 'supertramp', stories: 1}])
    end
  end
end



