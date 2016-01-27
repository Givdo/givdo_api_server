class AddFinishedToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :finished_at, :datetime

    Player.all.each do |player|
      player.touch(:finished_at) if !player.has_rounds?
    end
  end

  def down
    remove_column :players, :finished_at
  end
end
