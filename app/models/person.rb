class Person < ActiveRecord::Base
  belongs_to :ride

  attr_accessible :occupation, :origin
end
