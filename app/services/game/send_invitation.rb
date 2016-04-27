class Game::SendInvitation
  def self.call(user, game)
    params = {
      priority: :high,
      content_available: true,
      registration_ids: user.devices.collect(&:token),
      app: Rpush::Gcm::App.find_by_name(ENV['RPUSH_APP_NAME']),
      data: {
        message: "#{user.name} would like to play you in #{game.category.name}"
      },
    }

    Rpush::Gcm::Notification.create!(params)
  end
end
