require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :comment do
    body "Great Example Comment"
    association :user
    association :trip
  end

  factory :user do
    email                 { Faker::Internet.email }
    username              { |u| u.email.split("@").first }
    password              "password"
    password_confirmation "password"
    password_salt         "salt"
    cs_user               Faker::Name.first_name
    last_sign_in_at       Time.zone.now
    current_sign_in_ip    { '195.71.11.67' }
  end

  factory :munich_user, :parent => :user do
    current_sign_in_ip "195.71.11.67"
  end

  factory :berlin_user, :parent => :user do
    current_sign_in_ip "88.73.54.0"
  end

  factory :ride do
    waiting_time 15
    duration 2
  end

  factory :country_distance do
    distance 600000
    country  "Germany"
  end

  factory :trip do
    from 'Tehran'
    to 'Shiraz'
    departure "07/12/2011 10:00"
    arrival   "07/12/2011 20:00"
    travelling_with 0
    gmaps_duration   9.hours.to_i
    distance 1_646_989
    association(:user)
    hitchhikes 1
  end

  factory :future_trip do
    from "Barcelona"
    to "Madrid"
    departure 10.days.from_now
  end
end
