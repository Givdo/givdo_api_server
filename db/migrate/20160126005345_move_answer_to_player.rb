class MoveAnswerToPlayer < ActiveRecord::Migration
  def up
    add_reference :answers, :player
    add_index :answers, [:player_id]

    Answer.all.each do |answer|
      next unless answer.game
      user = User.find(answer.user_id)
      player = answer.game.player(user)
      answer.update_attribute :player_id, player.id
    end

    remove_reference :answers, :user
  end

  def down
    add_reference :answers, :user
    add_index :answers, [:user_id]

    Answer.all.each do |answer|
      next unless answer.game
      player = Player.find(answer.player_id)
      answer.update_attribute :user_id, player.user_id
    end

    remove_reference :answers, :player
  end
end
