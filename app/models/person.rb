class Person < ActiveRecord::Base
  include ToHash
  
  belongs_to :hitchhike
  
  def build_hash
    hash = self.to_hash(:name, :occupation, :mission, :origin, :age, :gender)
  end
end