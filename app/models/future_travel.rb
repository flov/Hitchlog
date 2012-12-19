class FutureTravel < ActiveRecord::Base
  attr_accessible :from, :departure, :to

  belongs_to :user
end
