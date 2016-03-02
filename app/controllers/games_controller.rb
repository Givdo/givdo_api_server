require_dependency 'givdo/facebook'

class GamesController < ApplicationController
  before_filter :authenticate_user!

  def single
    render :json => current_user.current_single_game, :include => 'players,trivia,trivia.options'
  end

  def versus
    user = Givdo::Facebook.friend(current_user, params[:uid])
    game = current_user.current_game_versus(user)
    render :json => game, :include => 'players,trivia,trivia.options'
  end
end
