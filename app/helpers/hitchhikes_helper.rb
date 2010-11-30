module HitchhikesHelper
  def distance(hitchhike)
    if hitchhike.distance > 0
      "#{hitchhike.distance / 1000} km" 
    else
      "unknown distance"
    end
  end
end