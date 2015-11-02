class CreateTrivia < ActiveRecord::Migration
  def change
    create_table :trivia do |t|
      t.text :question

      t.timestamps :null => false
    end
  end
end
