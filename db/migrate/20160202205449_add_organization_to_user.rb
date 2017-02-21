class AddOrganizationToUser < ActiveRecord::Migration
  def up
    add_reference :users, :organization
  end

  def down
    remove_reference :users, :organization
  end
end
