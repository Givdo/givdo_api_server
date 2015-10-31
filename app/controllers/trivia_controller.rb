class TriviaController < ApplicationController
  def show
    render json: Trivia.find(params[:id])
  end
end
