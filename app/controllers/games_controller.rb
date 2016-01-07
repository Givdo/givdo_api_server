class GamesController < ApplicationController
  before_filter :authenticate_user!

  def single
    render :json => current_user.current_single_game
  end

  def create
    game = Game.create! creator: current_user
    GameInvite.invite!(game, params.require(:provider), params[:invitees]) if has_invite?

    render :json => game
  end

  def raffle
    render :json => TriviaRaffle.next(current_user, game)
  end

  private

  def has_invite?
    params.has_key?(:invitees)
  end

  def game
    Game.find(params[:id])
  end
end
