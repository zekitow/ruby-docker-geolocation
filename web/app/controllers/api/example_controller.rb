module API
  class ExampleController < ApplicationController
  
    get '/api' do
      halt_data(200, Property.all)
    end

  end
end