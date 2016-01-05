class TriviaController < ApplicationController
  before_filter :authenticate_user!

  def show
    render :json => trivia
  end

  def raffle
    render :json => TriviaRaffle.next(current_user)
  end

  private

  def trivia
    Trivia.find(params[:id])
  end
end
