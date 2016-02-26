class AddGamesTriviasRelation < ActiveRecord::Migration
  def change
    create_table :games_trivia, :id => false do |t|
      t.references :game
      t.references :trivia
    end
  end
end
