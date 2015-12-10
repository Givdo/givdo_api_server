class GamesController < ApplicationController
  before_filter :authenticate_user!

  def invite
    provider, invitees = params.require(:provider), params.require(:invitees)
    render json: GameInvite.invite!(current_user, provider, invitees)
  end
end
