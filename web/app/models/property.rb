class Property < ActiveRecord::Base
  enum offer_type:    { sell: 'sell', rent: 'rent' }
  enum property_type: { apartment: 'apartment', single_family_house: 'single_family_house' }

  validates :offer_type, inclusion: { in: Property.offer_types }
  validates :property_type, inclusion: { in: Property.property_types }
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :house_number, presence: true
  validates :lng, presence: true
  validates :lat, presence: true

  # This method is used by
  # ElasticSearch for indexing data
  def to_hash
    {
      offer_type: self.offer_type,
      property_type: self.property_type,
      zip_code: self.zip_code,
      city: self.city,
      street: self.street,
      house_number: self.house_number,
      lng: self.lng,
      lat: self.lat,
      construction_year: self.construction_year,
      number_of_rooms: self.number_of_rooms,
      currency: self.currency,
      price: self.price
    }
  end
end