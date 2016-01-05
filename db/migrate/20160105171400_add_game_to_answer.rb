class AddGameToAnswer < ActiveRecord::Migration
  def change
    add_reference :answers, :game
  end
end
