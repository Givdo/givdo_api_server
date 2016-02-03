class AddOrganizationToUser < ActiveRecord::Migration
  def up
    add_reference :users, :organization
    User.where(organization_id: nil).update_all(organization_id: Organization.first.id)
    Player.where(organization_id: nil).update_all(organization_id: Organization.first.id)
  end

  def down
    remove_reference :users, :organization
  end
end
