module API
  class PropertyController < ApplicationController
  
    get '/api/properties' do
      request = Requests::Property::Get.new(params)
      request.validate!

      response = PropertyRepository.new.similar(request)
      halt_data(200, response.results)
    end
  end
end