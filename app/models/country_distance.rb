class CountryDistance < ActiveRecord::Base
  belongs_to :trip
  validates_uniqueness_of :trip_id, :scope => [:country]
end
