class Hitchhike < ActiveRecord::Base
  
  has_attached_file :photo, :styles => { :small => ["32x32#", :png] }
  
end
