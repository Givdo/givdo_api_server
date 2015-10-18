class AddCachedToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :cached, :boolean, :default => false
  end
end
