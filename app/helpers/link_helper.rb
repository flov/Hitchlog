module LinkHelper
  def photo_for_ride(ride)
    link_to ride.photo.url do
      image_tag(ride.photo.small.url, title: ride.photo_caption, class: 'tip alignright')
    end
  end
end
