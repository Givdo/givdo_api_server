require 'facebook_graph'

include FacebookGraph

class OrganizationsController < ApplicationController
  
  def index
    
    @organizations = Organization.all
    logger.debug "org count:" + @organizations.count.to_s
    logger.debug @organizations.to_s
    
    for organization in @organizations
      if !organization.cached?
        logger.debug "reading from graph for uncached FB ID " + organization.facebook_id
        organization.from_graph(get_graph)
      else
        logger.debug "organization " + organization['name'] + " is already cached"
      end
    end
    
    render json: @organizations
    
  end
        
end