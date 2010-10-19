# random photo
xml.instruct!
xml.record(:id => @hh.id, 
           :from => @hh.from,
           :to => @hh.to,
           :title => @hh.title) do 
  xml.photo(   :small => @hh.photo.url(:large),
               :large => @hh.photo.url(:original)) 
  for person in @hh.people do
    xml.people(:name => person.name,
               :occupation => person.occupation,
               :mission => person.mission,
               :origin => person.origin)
  end
end