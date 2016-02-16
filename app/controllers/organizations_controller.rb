class OrganizationsController < ApplicationController
  def index
    current_page = organizations.page(page_number).per(page_size)
    current_page.each(&method(:update_cache_if_needed))

    render :json => current_page
  end

  private

  def update_cache_if_needed(organization)
    UpdateOrganizationJob.perform_later(organization) unless organization.cached?
  end

  def organizations
    return Organization.ransack(params[:search]).result if params[:search]
    Organization
  end

  def page_size
    params[:page].try(:[], :size) || 10
  end

  def page_number
    params[:page].try(:[], :number)
  end
end
