class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :game, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.references :sender, index: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
