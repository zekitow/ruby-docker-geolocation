class PropertyRepository
  include Elasticsearch::Persistence::Repository
  client Elasticsearch::Client.new(url: $elastic_host, log: false)
  index :properties
  type  :property
  create_index!

  mapping do
    indexes :offer_type,        type: "text"
    indexes :property_type,     type: "text"
    indexes :zip_code,          type: "text"
    indexes :city,              type: "text"
    indexes :street,            type: "text"
    indexes :house_number,      type: "text"
    indexes :location,          type: "geo_point"
    indexes :construction_year, type: "integer"
    indexes :number_of_rooms,   type: "float"
    indexes :currency,          type: "text"
    indexes :price,             type: "float"
  end

  # Find similar properties based
  # on request information
  def similar(request, radius = "5km")
    self.search({
      query: {
        bool: {
          must: [
            { match: { offer_type: request.marketing_type } },
            { match: { property_type: request.property_type } }
          ],
          filter: {
            geo_distance: {
              distance: radius,
              location: {
                lat: request.lat,
                lon: request.lng
              }
            }
          }
        }
      }
    },{ search_type: :dfs_query_then_fetch })
  end
  
  # Import all data from Property model
  # into ElasticSearch 'properties' index
  def import_all!(options = { refresh: true })
    return if Property.count == 0

    body = Property.all.collect(&:to_hash).map do |a|
      { index: { _id: a.delete('id'), data: a } }
    end

    request  = {
      index: self.index,
      type:  self.type,
      body: body
    }.merge(options)

    self.client.bulk(request)
  end
end
