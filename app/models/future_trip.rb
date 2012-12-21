class FutureTrip < ActiveRecord::Base
  attr_accessible :from, :departure, :to

  belongs_to :user
end
