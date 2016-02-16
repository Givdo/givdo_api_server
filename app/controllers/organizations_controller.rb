class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.page(page_number).per(page_size)
    @organizations.each(&method(:update_cache_if_needed))

    render :json => @organizations
  end

  private

  def update_cache_if_needed(organization)
    UpdateOrganizationJob.perform_later(organization) unless organization.cached?
  end

  def page_size
    params[:page].try(:[], :size) || 10
  end

  def page_number
    params[:page].try(:[], :number)
  end
end
