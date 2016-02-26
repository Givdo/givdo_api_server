class RemoveRoundsFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :rounds
  end

  def down
    add_column :games, :rounds, :integer
  end
end
