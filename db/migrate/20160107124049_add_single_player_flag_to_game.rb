class AddSinglePlayerFlagToGame < ActiveRecord::Migration
  def up
    add_column :games, :single, :boolean, :default => false

    Game.all.each do |game|
      game.update_attribute(:single, game.players.count == 1)
    end
  end

  def down
    remove_column :games, :single
  end
end
