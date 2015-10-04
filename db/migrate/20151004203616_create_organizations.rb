class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :facebook_id
      t.string :name
      t.string :picture
      t.string :state
      t.string :city
      t.string :state
      t.string :zip
      t.string :street
      t.string :mission

      t.timestamps null: false
    end
  end
end
