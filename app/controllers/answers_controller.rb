class AnswersController < ApplicationController
  before_filter :authenticate_user!

  def create
    answer = current_game.answer! current_user, answer_params
    render :json => answer
  end

  private

  def current_game
    Game.find(params[:game_id])
  end

  def answer_params
    params.permit(:trivia_id, :option_id)
  end
end
