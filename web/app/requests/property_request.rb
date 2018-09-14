module Requests
  module Property
    class Get < BaseRequest
      attr_accessor :lng
      attr_accessor :lat
      attr_accessor :property_type
      attr_accessor :marketing_type

      validates :lng, :lat, :property_type, :marketing_type, presence: true
    end
  end
end