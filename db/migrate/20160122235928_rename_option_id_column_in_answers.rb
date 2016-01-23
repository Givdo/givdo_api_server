class RenameOptionIdColumnInAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :option_id, :trivia_option_id
  end
end
