FactoryGirl.define do
  factory :property do
    offer_type "sell"
    property_type "apartment"
    street "Street address"
    house_number "123"
    zip_code "18044-000"
    city "Sorocaba"
    lng -23.506270
    lat -47.455630
  end

  trait :to_sell do
    offer_type "sell"
  end

  trait :for_rent do
    offer_type "rent"
  end

  trait :apartment do
    property_type "apartment"
  end

  trait :family_house do
    property_type "single_family_house"
  end
end
