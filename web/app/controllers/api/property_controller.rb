module API
  class PropertyController < ApplicationController
  
    #
    # Endpoint responsible to filter properties near a
    # specific location (5km), property_type and marketing_type.
    # 
    # Calling example: /api/properties?lng=-23.528874&lat=-47.466840&property_type=apartment&marketing_type=rent
    get '/api/properties' do
      request = Requests::Property::Get.new(params)
      request.validate!

      response = PropertyRepository.new.similar(request)
      halt_data(200, format_property_results(response.results))
    end

    private

      # Apply the json format for results
      def format_property_results(results)
        results.map do | property |
          {
            house_number: property.house_number,
            street: property.street,
            city: property.city,
            zip_code: property.zip_code,
            lat: property.location["lat"],
            lng: property.location["lon"],
            price: property.price,
          }
        end
      end
  end
end