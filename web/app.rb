require './config/loaders'

$configs = YAML::load(File.read('./config/application.yml'))[$env.to_s]

require './config/elasticsearch'
require './config/require_all'
require './config/database'
require 'logger'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :logging
    $logger = Logger.new("#{settings.root}/log/#{settings.environment}.log", 'daily')
    use Rack::CommonLogger, $logger
  end

  use Rack::Parser, parsers: {
    'application/json' => proc do |data|
      JSON.parse(data)
    end
  }

  use HomeController
  use API::ExampleController

  run! if app_file == $0
end
