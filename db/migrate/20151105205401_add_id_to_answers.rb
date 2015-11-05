class AddIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :id, :primary_key
  end
end
