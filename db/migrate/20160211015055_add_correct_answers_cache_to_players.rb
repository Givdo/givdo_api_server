class AddCorrectAnswersCacheToPlayers < ActiveRecord::Migration
  def down
    remove_column :players, :score
  end

  def up
    add_column :players, :score, :integer, default: 0

    Player.all.each do |player|
      player.update_attribute(:score, player.answers.correct.count)
    end
  end
end
