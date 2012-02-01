class Person < ActiveRecord::Base
  belongs_to :ride

  attr_accessible :occupation, :mission, :origin
end
