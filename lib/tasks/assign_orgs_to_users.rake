# Usage: rake givdo:assign_orgs
# NOTE: Will assign first organization to all Users and Players.
namespace :givdo do
  desc "Assign organizations to users"
  task :assign_orgs => :environment do
    User.where(organization_id: nil).update_all(organization_id: Organization.first.id)
    Player.where(organization_id: nil).update_all(organization_id: Organization.first.id)
  end
end