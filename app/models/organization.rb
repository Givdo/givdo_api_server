class Organization < ActiveRecord::Base
  
  def from_graph(graph)
    ograph = get_graph.get_object(self['facebook_id'])
    self['name'] = ograph['name']
    self['city'] = ograph['location']['city']
    self['state'] = ograph['location']['state']
    self['zip'] = ograph['location']['zip']
    self['street'] = ograph['location']['street']
    self['picture'] = graph.get_picture(self['facebook_id'], {type: "large"})
    self['mission'] = ograph['mission']
  end
   
end
