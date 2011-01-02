class Trip < ActiveRecord::Base
  has_many :hitchhikes, :dependent => :destroy
  belongs_to :user
  
  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  
  concerned_with :googlemaps

  cattr_reader :per_page
  @@per_page = 40

  attr_accessor :rides

  before_save do
    # build as much hitchhikes on top of the ride as needed
    rides.to_i.times{ hitchhikes.build }
  end

  def to_s
    if date.nil?
      "#{from} -> #{to}"
    else
      "#{date.strftime("%d %b %Y")}: #{from} &rarr; #{to}".html_safe
    end
  end

  def to_param
    from_param = from.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    to_param   = to.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    "#{id}-#{from_param}->#{to_param}"
  end
  
  def to_date
    date.nil? ? '' : date.strftime("%d. %B %Y")    
  end
end
