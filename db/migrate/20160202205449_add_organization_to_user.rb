class AddOrganizationToUser < ActiveRecord::Migration
  def up
    add_reference :users, :organization
    User.where(organization_id: nil).update_all(organization_id: Organization.first)
    Player.where(organization_id: nil).update_all(organization_id: Organization.first)
  end

  def down
    remove_reference :users, :organization
  end
end
