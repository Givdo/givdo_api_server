class Api::V1::GamesController < Api::V1::ApiController
  rescue_from Givdo::Exceptions::GamesQuotaExeeded do |exception|
    render_exception exception, status: :method_not_allowed
  end

  def single
    game = Game::StartSingle.call(current_user)
    render json: game, include: 'players,trivia,trivia.options'
  end

  def versus
    friend = Givdo::Facebook.friend(current_user, params[:uid])
    game = Game::StartVersus.call(current_user, friend)
    render json: game, include: 'players,trivia,trivia.options'
  end
end
