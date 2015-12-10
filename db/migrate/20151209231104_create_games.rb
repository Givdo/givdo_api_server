class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :creator, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :games_users, :id => false do |t|
      t.references :game, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
