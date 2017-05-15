class AddActiveToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :active, :boolean, default: true
  end
end
