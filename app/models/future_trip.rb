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

  default_scope where("departure >= ?", Time.now)

  def to_s
    "#{formatted_from} &rarr; #{formatted_to}".html_safe
  end

  def formatted_to
    if to_city.present? and to_country.present?
      "#{to_city}, #{to_country}"
    elsif to_city.present?
      to_city
    else
      to
    end
  end

  def formatted_from
    if from_city.present? and from_country.present?
      "#{from_city}, #{from_country}"
    elsif from_city.present?
      from_city
    else
      from
    end
  end

  def formatted_time
    departure.strftime("%d %b %Y")
  end
end
