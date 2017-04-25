class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :company_name
      t.string :image
      t.string :link
      t.integer :impressions, default: 0
      t.integer :clicks, default: 0

      t.timestamps null: false
    end

    create_join_table :users, :advertisements do |t|
      t.index [:user_id, :advertisement_id]

      t.timestamps null: false
    end
  end
end
