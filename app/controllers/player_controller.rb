class PlayerController < ApplicationController
  before_filter :authenticate_token!

  def update
    current_player.update! params.permit(:organization_id)
    render :json => current_game, :include => 'players,trivia,trivia.options'
  end

  private

  def current_player
    @current_player ||= current_game.player(current_user)
  end

  def current_game
    @current_game ||= Game.find(params[:game_id])
  end
end
