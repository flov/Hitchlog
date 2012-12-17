json.id                @ride.id
json.trip_path         trip_path(@ride.trip)
json.images_for_ride   images_for_ride(@ride)
json.route             @ride.trip.route
json.from              @ride.trip.from
json.to                @ride.trip.to
json.caption           render 'rides/hitchslider/caption', ride: @ride
json.photo_url         @ride.photo.url(:cropped)
json.title             "<h2>#{link_to @ride.title, trip_path(@ride.trip)}</h2>"
json.story             @ride.markdown_story
json.comments          render 'rides/hitchslider/comments', comments: @ride.trip.comments
json.add_comment       render 'trips/add_comment', trip: @ride.trip
json.next_link         next_ride_path(id: @ride.to_param)
json.prev_link         prev_ride_path(id: @ride.to_param)
