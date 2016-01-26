class RemoveGameFromAnswers < ActiveRecord::Migration
  def change
    remove_reference :answers, :game
  end
end
