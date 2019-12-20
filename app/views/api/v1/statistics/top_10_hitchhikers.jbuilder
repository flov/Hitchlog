json.top_10_hitchhikers @users do |user|
  json.username user[:username].capitalize
  json.total_distance user[:total_distance]
end
