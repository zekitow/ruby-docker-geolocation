require 'elasticsearch'
$elastic_host   = $configs['elastic_search']['host']
$elastic_client = Elasticsearch::Client.new(host: $elastic_host, log: false, timeout: 120)