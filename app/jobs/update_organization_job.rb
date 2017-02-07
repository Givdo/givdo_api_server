require_dependency 'givdo/facebook'

class UpdateOrganizationJob < ActiveJob::Base
  queue_as :default

  def perform(organization)
    ograph = graph.get_object(organization.facebook_id, fields: [:mission, :location, :name])
    picture = graph.get_picture_data(organization.facebook_id, {:type => "large"})

    organization.cache!

    organization.name    = ograph['name']
    organization.mission = ograph['mission']

    if location = ograph['location']
      organization.city    = location['city']
      organization.state   = location['state']
      organization.zip     = location['zip']
      organization.street  = location['street']
    end

    organization.picture = picture['url']

    organization.save
  rescue Koala::Facebook::ClientError => error
    logger.error error
  end

  private

  def graph
    Givdo::Facebook.graph
  end
end
