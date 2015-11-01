class CreateTriviaOptions < ActiveRecord::Migration
  def change
    create_table :trivia_options do |t|
      t.string :text
      t.references :trivia

      t.timestamps null: false
    end
  end
end
