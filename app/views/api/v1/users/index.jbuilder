json.pagination do
  json.current_page @users.current_page.to_i
  json.total_pages @users.total_pages
end

json.users @users do |user|
  json.id user.id
  json.username user.username
  json.age user.age
  json.profile_image avatar_url(user)
  json.gender user.gender
  json.member_since time_ago_in_words(user.created_at)
  json.updated_at time_ago_in_words(user.updated_at)
  json.hitchhiked_kms user.hitchhiked_kms
  json.number_of_rides user.no_of_rides
  json.number_of_trips user.no_of_trips
end
