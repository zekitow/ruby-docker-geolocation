require 'json'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  set :show_exceptions, false
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }

  # Specify your authorization logic
  before do
    content_type :json
  end

  #
  # Captures all errors 400 and returns.
  #
  error BadRequestError do
    $logger.error("Internal server error: #{env['sinatra.error']}")
    $logger.error("PATH: #{request.path}");
    $logger.error("PARAMS: #{params}\n\n");

    halt_with(400, env['sinatra.error'].message)
  end

  error UnauthorizedError do
    $logger.error("Unauthorized error: #{env['sinatra.error']}")
    $logger.error("PATH: #{request.path}");
    $logger.error("PARAMS: #{params}\n\n");

    halt_with(401, env['sinatra.error'].message)
  end

  error do
    $logger.error("Internal server error: #{env['sinatra.error']}")
    $logger.error("PATH: #{request.path}\r\nPARAMS: #{params}");
    halt_with(500, 'Internal server error.')
  end

  private 

    #
    # Returns an error json, containing the http status reported.
    #
    def halt_with(status, message)
      halt status, { 'Content-Type' => 'application/json'},
                   { status: status, message: message }.to_json
    end

    #
    # Returns an error json, containing the http status reported.
    #
    def halt_data(status, data)
      halt status, { 'Content-Type' => 'application/json'}, data.to_json
    end
end
