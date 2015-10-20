class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    @organizations.each(&method(:update_cache_if_needed))

    render json: @organizations
  end

  private

  def update_cache_if_needed(organization)
    UpdateOrganizationJob.perform_later(organization) unless organization.cached?
  end
end
