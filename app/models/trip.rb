class Trip < ActiveRecord::Base
  has_many :hitchhikes, :dependent => :destroy
  belongs_to :user
  
  validates :from, :presence => true
  validates :to, :presence => true
  validates :distance, :numericality => true
  validates :user_id, :presence => true
  
  concerned_with :googlemaps

  attr_accessor :rides

  before_save do
    # build as much hitchhikes on top of the ride as previously defined
    rides.to_i.times{ hitchhikes.build }
  end

  def to_s
    "#{date.strftime("%d %b %Y")}: #{from} -> #{to}"
  end
end
