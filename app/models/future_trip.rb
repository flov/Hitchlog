class FutureTrip < ActiveRecord::Base
  attr_accessible :from,
                  :from_lat,
                  :from_lng,
                  :from_city,
                  :from_country,
                  :from_country_code,
                  :departure,
                  :to,
                  :to_lat,
                  :to_lng,
                  :to_city,
                  :to_country,
                  :to_country_code,
                  :description

  belongs_to :user

  geocoded_by :from, latitude: :from_lat, longitude: :from_lng

  validates :from, presence: true
  validates :to, presence: true
  validates :departure, presence: true
end
