module UsersHelper
  def link_to_user(user)
    link_to(user, user_path(user))
  end

  def florian
    link_to 'Florian', user_path('flov')
  end

  def ben
    link_to "Benjamin Mceldowney", user_path('benjemce')
  end

  def samuel
    link_to "Samuel Del Bello", user_path("sdelbello")
  end

  def user_with_gender(user)
    link_to "#{h(user)} #{hitchhiker_gender(user.gender)}".html_safe, user_path(user)
  end

  def avatar_url(user)
    if user.facebook_user?
      "https://graph.facebook.com/#{user.uid}/picture?type=normal"
    else
      gravatar_url(user, size: "normal")
    end
  end
end
