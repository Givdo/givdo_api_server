class ChangeCachedToCachedAtOnOrganization < ActiveRecord::Migration
  def up
    remove_column :organizations, :cached
    add_column :organizations, :cached_at, :datetime
  end

  def down
    remove_column :organizations, :cached_at
    add_column :organizations, :cached, :boolean
  end
end
