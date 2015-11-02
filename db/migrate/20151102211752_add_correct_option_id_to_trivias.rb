class AddCorrectOptionIdToTrivias < ActiveRecord::Migration
  def change
    add_column :trivia, :correct_option_id, :integer
  end
end
