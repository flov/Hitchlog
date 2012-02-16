class Trip < ActiveRecord::Base
  has_many :rides, :dependent => :destroy
  has_many :country_distances, :dependent => :destroy
  belongs_to :user

  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  validates :hitchhikes, :presence => true, :if => :new_record

  concerned_with :googlemaps,
                 :countries

  cattr_reader :per_page
  @@per_page = 20

  attr_accessor :hitchhikes, :start_time, :end_time


  after_create :get_country_distance
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
    self.start.nil? ? nil : self.start.strftime("%d %B %Y")
  end

  def arrival
    self.start.nil? ? nil : self.start.strftime("%d %B %Y %H:%S")
  end

  def departure
    self.end.nil? ? nil : self.end.strftime("%d %B %Y %H:%S")
  end

  def duration
    if self.end and self.start
      self.end - self.start
    else
      nil
    end
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
    if self.gmaps_duration
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
    new_record?
  end

  def duration_difference
    difference = duration.to_f - gmaps_duration.to_f/60/60
    if difference < 0
      difference = (gmaps_duration.to_f/60/60 - duration.to_f) * -1
    end
    difference
  end

  def sanitize_address(direction)
    if !self.send("#{direction}_city").blank?
      address = self.send("#{direction}_city")
    elsif !self.send("#{direction}_formatted_address").blank?
      address = self.send("#{direction}_formatted_address")
    else
      address = self.send(direction)
    end
  end

  def overall_experience
    experiences = self.rides.map{|ride| ride.experience}
    if experiences.include? 'negative'
      'negative'
    elsif experiences.include? 'neutral'
      'neutral'
    elsif experiences.include? 'positive'
      'positive'
    end
  end
end
