class CountryDistance < ActiveRecord::Base
  belongs_to :trip
  validates :distance, :numericality => true
  validates_uniqueness_of :trip_id, :scope => [:country]
end
