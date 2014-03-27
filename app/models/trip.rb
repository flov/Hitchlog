class Trip < ActiveRecord::Base
  include Gmaps
  include AccurateDistanceOfTimeInWordsHelper

  has_many :rides, dependent: :destroy
  has_many :country_distances, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :user

  validates :from,       presence: true
  validates :to,         presence: true
  validates :departure,  presence: true
  validates :arrival,    presence: true, after_departure: true
  validates :user_id,    presence: true
  validates :hitchhikes, numericality:  true, presence: true, if: :new_record
  validates :travelling_with, presence: true

  validates :distance,   numericality: true

  cattr_reader :per_page
  @@per_page = 20

  attr_accessor   :hitchhikes,
                  :departure_time,
                  :arrival_time

  attr_accessible :from,
                  :to,
                  :hitchhikes,
                  :departure,
                  :departure_time,
                  :arrival,
                  :arrival_time,
                  :travelling_with,
                  :route,
                  :distance,
                  :gmaps_duration,
                  :from_lat,
                  :from_lng,
                  :from_formatted_address,
                  :from_city,
                  :from_country,
                  :from_postal_code,
                  :from_street,
                  :from_street_no,
                  :from_country_code,
                  :to_lat,
                  :to_lng,
                  :to_formatted_address,
                  :to_city,
                  :to_country,
                  :to_postal_code,
                  :to_street,
                  :to_street_no,
                  :to_country_code

  after_create :get_country_distance

  scope :alone,      where(travelling_with: 0)
  scope :in_pairs,   where(travelling_with: 1)
  scope :with_three, where(travelling_with: 2)
  scope :with_four,  where(travelling_with: 3)

  before_create do
    # build as much rides on top of the ride as needed
    hitchhikes.to_i.times{|i| rides.build(:number => i+1) }
  end

  def to_s
    origin = sanitize_address('from')
    destin = sanitize_address('to')

    "#{origin} &rarr; #{destin}".html_safe
  end

  def to_param
    origin = CGI::escape(sanitize_address('from'))
    destin = CGI::escape(sanitize_address('to'))

    "#{id}-#{origin}-to-#{destin}".parameterize
  end

  def to_date
    departure.strftime("%d %B %Y")
  end

  def tag_list
    self.rides.flat_map(&:tag_list)
  end

  def duration
    if self.arrival and self.departure
      self.arrival - self.departure
    else
      nil
    end
  end

  def add_ride
    self.rides.build(number: self.rides.size + 1)
    self.save
  end

  def kmh
    kilometers = self.distance.to_f / 1000
    hour       = self.duration / 60 / 60
    (kilometers / hour).to_i
  end

  def hitchability
    if self.gmaps_duration && self.gmaps_duration != 0 && self.duration
      (self.duration / self.gmaps_duration).round 2
    else
      nil
    end
  end

  def gmaps_difference
    if self.gmaps_duration and self.duration
      (self.duration - self.gmaps_duration).to_i
    else
      nil
    end
  end

  def to_city_sanitized
    if !self.to_city.blank?
      self.to_city
    elsif !self.to_country.blank?
      self.to_country
    else
      self.to
    end
  end

  def from_city_sanitized
    if !self.from_city.blank? 
      self.from_city
    elsif !self.from_country.blank?
      self.from_country 
    else
      self.from
    end
  end

  def new_record
    self.new_record?
  end

  def duration_difference
    difference = duration.to_f - gmaps_duration.to_f/60/60
    if difference < 0
      difference = (gmaps_duration.to_f/60/60 - duration.to_f) * -1
    end
    difference
  end

  def sanitize_address(direction)
    if self.send("#{direction}_city").present?
      self.send("#{direction}_city")
    elsif self.send("#{direction}_formatted_address").present?
      self.send("#{direction}_formatted_address")
    elsif self.send(direction).nil?
      ''
    else
      self.send(direction)
    end
  end

  def overall_experience
    experiences = self.rides.map(&:experience)
    if experiences.include? 'extremely negative'
      'extremely negative'
    elsif experiences.include? 'extremely positive'
      'extremely positive'
    elsif experiences.include? 'negative'
      'negative'
    elsif experiences.include? 'neutral'
      'neutral'
    elsif experiences.include? 'positive'
      'positive'
    end
  end

  def hitchhiked_kms
    distance / 1000
  end

  def total_waiting_time
    waiting_times = self.rides.map(&:waiting_time).compact
    if waiting_times.any?
      accurate_distance_of_time_in_words(waiting_times.sum.minutes)
    else
      nil
    end
  end

  def total_driving_time
    driving_times = self.rides.map(&:duration).compact
    if driving_times.any?
      accurate_distance_of_time_in_words(driving_times.sum.hours)
    else
      nil
    end
  end

  def departure_time=(time)
    time = Time.parse time
    if self.departure
      self[:departure] = DateTime.new(departure.year, departure.month, departure.day, time.hour, time.min, time.sec)
    end
  end

  def arrival_time=(time)
    time = Time.parse time
    if self.arrival
      self[:arrival] = DateTime.new(arrival.year, arrival.month, arrival.day, time.hour, time.min, time.sec)
    end
  end

  def countries
    self.country_distances.map(&:country)
  end

  def get_country_distance
    countries = Gmaps.countries(from, to)
    if %w(ZERO_RESULTS OFFLINE NOT_FOUND OVER_QUERY_LIMIT REQUEST_DENIED INVALID_REQUEST).include? countries
      [['Unknown', 10000]]
    else
      countries.each do |country_distance|
        cd = CountryDistance.where(:country => country_distance[0],
                                   :trip_id => self.id)
        if cd.empty?
          self.country_distances.create(:country  => country_distance[0],
                                        :distance => country_distance[1])
        elsif cd.first.distance != country_distance
          cd.first.update_attribute :distance, country_distance[1]
        end
      end
    end
  end

  def get_city
    self.from_city = Gmaps.city(from)
    self.to_city   = Gmaps.city(to)
  end

  def get_country
    self.from_country = Gmaps.country(from)
    self.to_country   = Gmaps.country(to)
  end

  def get_formatted_addresses
    self.from_formatted_address = Gmaps.formatted_address(from)
    self.to_formatted_address = Gmaps.formatted_address(to)
  end

  def average_speed
    return 0 if duration == 0
    "#{((distance/1000) / (duration/60/60)).round } kmh"
  end

  def age
    ((departure.to_date - user.date_of_birth) / 356).to_i if self.user.date_of_birth
  end
end
