class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.page(params[:page]).per(per_page)
    @organizations.each(&method(:update_cache_if_needed))

    render json: @organizations
  end

  private

  def update_cache_if_needed(organization)
    UpdateOrganizationJob.perform_later(organization) unless organization.cached?
  end

  def per_page
    params[:per_page] || 10
  end
end
