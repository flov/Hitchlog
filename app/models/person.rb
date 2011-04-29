class Person < ActiveRecord::Base
  include ToHash
  
  belongs_to :ride
  
  attr_accessible :name, :occupation, :mission, :origin, :age, :gender
  
  def build_hash
    hash = self.to_hash(:name, :occupation, :mission, :origin, :age, :gender)
  end
  
  def to_s
    [name, occupation, mission, origin].compact.delete_if{|x| x == ''}.join(', ')
  end
end
