class CreateProperty < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string  :offer_type
      t.string  :property_type
      t.string  :zip_code, null: false
      t.string  :city, null: false
      t.string  :street
      t.string  :house_number
      t.decimal :lng, precision: 11, scale: 8
      t.decimal :lat, precision: 11, scale: 8
      t.integer :construction_year
      t.decimal :number_of_rooms, precision: 15, scale: 2
      t.string  :currency
      t.decimal :price, precision: 15, scale: 2
      t.timestamps null: false
    end
  end
end
