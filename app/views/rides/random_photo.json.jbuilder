json.trip_path trip_path(@ride.trip)
json.images_for_ride images_for_ride(@ride)
#json.partial! "rides/hitchsilder/caption", ride: @ride

json.photo_url @ride.photo.url(:cropped)
json.route     @ride.trip.route
json.from      @ride.trip.from
json.to        @ride.trip.to
