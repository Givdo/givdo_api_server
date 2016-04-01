class CreateCycleScores < ActiveRecord::Migration
  def change
    create_table :cycle_scores do |t|
      t.integer :score
      t.belongs_to :cycle, foreign_key: true, index: true
      t.belongs_to :organization, foreign_key: true, index: true

      t.timestamps null: false
    end
  end
end
