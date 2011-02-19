class Trip < ActiveRecord::Base
  has_many :hitchhikes, :dependent => :destroy
  belongs_to :user

  default_scope :order => 'start DESC'
  
  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  validates :rides, :presence => true, :if => :new_record
  validates :start, :presence => true

  
  concerned_with :googlemaps

  cattr_reader :per_page
  @@per_page = 40

  attr_accessor :rides

  before_save do
    # build as much hitchhikes on top of the ride as needed
    rides.to_i.times{ hitchhikes.build }
  end

  def to_s
    "#{from_city} &rarr; #{to_city}".html_safe
  end

  def to_param
    from_param = from.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    to_param   = to.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    "#{id}-#{from_param}->#{to_param}"
  end
  
  def to_date
    start.nil? ? '' : start.strftime("%d. %B %Y")    
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
end
