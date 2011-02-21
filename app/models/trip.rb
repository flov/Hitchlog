class Trip < ActiveRecord::Base
  has_many :hitchhikes, :dependent => :destroy
  belongs_to :user

  default_scope :order => 'start DESC'
  
  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  validates :rides, :presence => true, :if => :new_record
  
  concerned_with :googlemaps

  cattr_reader :per_page
  @@per_page = 40

  attr_accessor :rides, :start_time, :end_time

  before_save do
    # build as much hitchhikes on top of the ride as needed
    rides.to_i.times{ hitchhikes.build }
  end

  before_create :assign_time

  def to_s
    "#{from_city_sanitized} &rarr; #{to_city_sanitized}".html_safe
  end

  def to_param
    from_param = from.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    to_param   = to.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    "#{id}-#{from_param}->#{to_param}"
  end
  
  def to_date
    start.nil? ? '' : start.strftime("%d. %B %Y")    
  end

  def to_city_sanitized
    self.to_city.blank? ? self.to_country : self.to_city
  end

  def from_city_sanitized
    self.from_city.blank? ? self.from_country : self.from_city
  end

  def new_duration
    if !self.duration.nil?
      self.duration
    else
      (self.end - self.start)/60/60
    end
  end

  def new_record
    new_record?
  end

  def assign_time
    # combining the time input with the date input (02/11/2011 02:00 pm)
    self.start = Time.parse("#{self.start.to_s.split(' ').first} #{self.start_time}")
    self.end = Time.parse("#{self.end.to_s.split(' ').first} #{self.end_time}")
  end
end
