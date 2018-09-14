class Property < ActiveRecord::Base
  validates :offer_type, presence: true
  validates :property_type, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :house_number, presence: true
  validates :lng, presence: true
  validates :lat, presence: true

  def to_hash
    {
      offer_type: offer_type,
      property_type: property_type,
      zip_code: zip_code,
      city: city,
      street: street,
      house_number: house_number,
      lng: lng,
      lat: lat,
      construction_year: construction_year,
      number_of_rooms: number_of_rooms,
      currency: currency,
      price: price,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end

class Repo
  include Elasticsearch::Persistence::Repository
  client Elasticsearch::Client.new(url: $elastic_host, log: false)
  index :properties
  type  :property
  create_index!
end
