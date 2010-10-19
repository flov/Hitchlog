xml.record(:id => @hitchhike.id, :title => @hitchhike.name) do 
  xml.photo(:url => @hitchhike.photo.url(:large)) 
end 