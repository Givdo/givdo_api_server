class AnswersController < ApplicationController
  before_filter :authenticate_token!

  def create
    answer = current_game.answer! current_user, answer_params
    render :json => answer, :include => 'game,game.trivia,game.trivia.options,game.players'
  end

  private

  def current_game
    Game.find(params[:game_id])
  end

  def answer_params
    params.permit(:trivia_id, :trivia_option_id)
  end
end
