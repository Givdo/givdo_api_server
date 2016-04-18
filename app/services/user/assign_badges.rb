class User::AssignBadges
  def self.call(user)
    badges = Badge.next_badges_for(user)
    user.add_badges(badges)
  end
end
