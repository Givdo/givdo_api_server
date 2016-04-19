require_dependency 'givdo/facebook'

class Api::V1::GamesController < Api::V1::ApiController
  def single
    render :json => Match.current(current_user), :include => 'players,trivia,trivia.options'
  end

  def versus
    user = Givdo::Facebook.friend(current_user, params[:uid])
    game = Match.current(current_user, user)
    render :json => game, :include => 'players,trivia,trivia.options'
  end
end
