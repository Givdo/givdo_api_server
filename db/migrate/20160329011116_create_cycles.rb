class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.datetime :ended_at

      t.timestamps null: false
    end
  end
end
