class PropertyRepository
  include Elasticsearch::Persistence::Repository
  client Elasticsearch::Client.new(url: $elastic_host, log: false)
  index :properties
  type  :property
  create_index!

  # Import all data from Property model
  # into ElasticSearch 'properties' index
  def import_all!(options = { refresh: true })
    return if Property.count == 0
    body = Property.all.as_json.map { |a| { index: { _id: a.delete('id'), data: a } } }

    request  = {
      index: self.index,
      type:  self.type,
      body: body
    }.merge(options)

    response = self.client.bulk(request)
    $logger.error("[BaseIndex] ===> Import error #{response}") if response['errors']
    response
  end
end
