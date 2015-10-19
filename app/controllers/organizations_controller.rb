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

      graph = get_graph.get_object(organization.facebook_id)
      organization['name'] = graph['name']
      organization['city'] = graph['location']['city']
      organization['state'] = graph['location']['state']
      organization['zip'] = graph['location']['zip']
      organization['street'] = graph['location']['street']
      organization['picture'] = get_graph.get_picture(organization.facebook_id, {type:"large"})
      organization['mission'] = graph['mission']
      logger.debug graph.to_s
    end

    render json: @organizations

  end

end