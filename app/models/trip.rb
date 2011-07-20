class Trip < ActiveRecord::Base
  has_many :rides, :dependent => :destroy
  has_many :country_distances, :dependent => :destroy
  belongs_to :user

  default_scope :order => 'start DESC'
  
  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  validates :hitchhikes, :presence => true, :if => :new_record
  
  concerned_with :googlemaps, :countries

  cattr_reader :per_page
  @@per_page = 20

  attr_accessor :hitchhikes, :start_time, :end_time

  before_save do
    # build as much rides on top of the ride as needed
    hitchhikes.to_i.times{|i| rides.build(:number => i+1) }
  end

  def to_s
    origin = sanitize_address('from')
    destin = sanitize_address('to')

    "#{origin} &rarr; #{destin}".html_safe
  end

  def to_param
      origin = sanitize_param(CGI::escape(sanitize_address('from')))
      destin = sanitize_param(CGI::escape(sanitize_address('to')))

    "#{id}_#{origin}_to_#{destin}".downcase
  end
  
  def to_date
    start.nil? ? '' : start.strftime("%d %B %Y")    
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

  def new_duration
    if !self.duration.nil?
      self.duration
    elsif !self.start.nil? && self.end.nil?
      (self.end - self.start)/60/60
    else
      nil
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

  private

  def sanitize_address(direction)
    if !self.send("#{direction}_city").blank?
      address = self.send("#{direction}_city")
    elsif !self.send("#{direction}_formatted_address").blank?
      address = self.send("#{direction}_formatted_address")
    else
      address = self.send(direction)
    end
  end

  def sanitize_param(param)
    param.gsub(/[^[:alnum:]]/,'_').gsub(/-{2,}/,'_')
  end
end
