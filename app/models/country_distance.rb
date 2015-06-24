class CountryDistance < ActiveRecord::Base
  belongs_to :trip
  validates :distance, :numericality => true
  validates_uniqueness_of :trip_id, :scope => [:country]

  def distance_in_kms
    distance / 1000
  end
end
