json.trip_path trip_path(@ride.trip)
json.images_for_ride images_for_ride(@ride)
json.route     @ride.trip.route
json.from      @ride.trip.from
json.to        @ride.trip.to
json.caption   render 'rides/hitchslider/caption', ride: @ride
json.photo_url @ride.photo.url(:cropped)
