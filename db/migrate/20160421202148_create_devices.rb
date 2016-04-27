class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :token
      t.string :platform
      t.boolean :enabled, default: true
      t.belongs_to :user, foreign_key: true, index: true

      t.timestamps null: false
    end
  end
end
