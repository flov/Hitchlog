json.array! @users do |user|
  json.id user.id
  json.username user.username
  json.age user.age
  json.profile_image avatar_url(user)
  json.gender user.gender
  json.member_since time_ago_in_words(user.created_at)
  json.updated_at time_ago_in_words(user.updated_at)
  json.hitchhiked_kms user.hitchhiked_kms
end
