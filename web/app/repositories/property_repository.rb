class PropertyRepository
  include Elasticsearch::Persistence::Repository
  client Elasticsearch::Client.new(url: $elastic_host, log: false)
  index :properties
  type  :property
  create_index!
end
