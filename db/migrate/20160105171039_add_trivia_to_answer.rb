class AddTriviaToAnswer < ActiveRecord::Migration
  def change
    add_reference :answers, :trivia
  end
end
