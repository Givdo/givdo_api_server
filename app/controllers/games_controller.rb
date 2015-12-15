class GamesController < ApplicationController
  before_filter :authenticate_user!

  def create
    game = Game.create! creator: current_user
    GameInvite.invite!(game, params.require(:provider), params[:invitees]) if has_invite?

    render :json => game
  end

  private

  def has_invite?
    params.has_key?(:invitees)
  end
end
