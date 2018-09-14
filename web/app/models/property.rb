class Property < ActiveRecord::Base
  validates :offer_type, presence: true
  validates :property_type, presence: true
  validates :street, presence: true
  validates :house_number, presence: true
  validates :lng, presence: true
  validates :lat, presence: true
end