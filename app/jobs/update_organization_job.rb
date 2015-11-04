require_dependency 'givdo/facebook'

class UpdateOrganizationJob < ActiveJob::Base
  queue_as :default

  def perform(organization)
    ograph = Givdo::Facebook.graph.get_object(organization.facebook_id)

    organization.cache!

    organization.name    = ograph['name']
    organization.mission = ograph['mission']

    if location = ograph['location']
      organization.city    = location['city']
      organization.state   = location['state']
      organization.zip     = location['zip']
      organization.street  = location['street']
    end

    organization.picture = Givdo::Facebook.graph.get_picture(organization.facebook_id, {type: "large"})

    organization.save
  rescue Koala::Facebook::ClientError => error
    logger.error error
  end
end
