class Property < ActiveRecord::Base
  validates :offer_type, presence: true
  validates :property_type, presence: true
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