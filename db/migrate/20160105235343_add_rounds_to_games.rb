class AddRoundsToGames < ActiveRecord::Migration
  def change
    add_column :games, :rounds, :integer, :default => 10
  end
end
