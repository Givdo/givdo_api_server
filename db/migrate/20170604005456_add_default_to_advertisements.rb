class AddDefaultToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :default, :boolean, default: false
  end
end
