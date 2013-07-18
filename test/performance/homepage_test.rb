require 'test_helper'
require 'rails/performance_test_help'

class HomepageTest < ActionDispatch::PerformanceTest
  def test_homepage
    20.times{ FactoryGirl.create(:user) }
    User.scoped.each do |user|
      trip = FactoryGirl.create(:trip, user_id: user.id)
      FactoryGirl.create(:ride, trip_id: trip.id, title: Faker::Lorem.words, story: Faker::Lorem.paragraph)
    end

    get '/'
  end
end
