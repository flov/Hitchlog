class FutureTrip < ActiveRecord::Base
  belongs_to :user

  geocoded_by :from, latitude: :from_lat, longitude: :from_lng

  validates :from, presence: true
  validates :to, presence: true
  validates :departure, presence: true, not_in_past: true

  scope :relevant, -> { where("departure >= ?", Time.now) }
  scope :earliest_departing, -> { order(:departure) }

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

  def formatted_departure
    departure.strftime("%d %b %Y")
  end
end
