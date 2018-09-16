require './spec/spec_helper'

describe API::PropertyController, elasticsearch: true do
  describe 'GET /api/properties' do
    context 'when request is not valid' do
      subject { get '/api/properties' }

      it { expect(subject.status).to eql(400) }
      it { expect(JSON.parse(subject.body)["message"]).to include("Lng can't be blank") }
      it { expect(JSON.parse(subject.body)["message"]).to include("Lat can't be blank") }
      it { expect(JSON.parse(subject.body)["message"]).to include("Property type can't be blank")  }
      it { expect(JSON.parse(subject.body)["message"]).to include("Marketing type can't be blank") }
    end

    context 'when request is valid' do
      context 'and are no data matched' do
        subject { get '/api/properties?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell' }

        it { expect(subject.status).to eql(200) }
        it { expect(JSON.parse(subject.body)).to eq([]) }
      end

      context 'and are data matched' do
        subject { get '/api/properties?lng=-23.528874&lat=-47.466840&property_type=apartment&marketing_type=rent' }

        before do
          FactoryGirl.create(:property, :family_house, :rent, zip_code: '001', lng: -23.528874, lat: -47.466840, price: 1000) # beer caps (searching point!)
          FactoryGirl.create(:property, :apartment,    :sell, zip_code: '002', lng: -23.527678, lat: -47.468569, price: 1000) # jack pub  (2km)
          FactoryGirl.create(:property, :apartment,    :sell, zip_code: '003', lng: -23.568083, lat: -47.459705, price: 1000) # cervejaria bamberg (4.49km)
          FactoryGirl.create(:property, :apartment,    :rent, zip_code: '004', lng: -23.505449, lat: -47.470245, price: 1000) # the crown pub (2.48km)
          FactoryGirl.create(:property, :family_house, :rent, zip_code: '005', lng: -23.495320, lat: -47.435167, price: 1000) # bardolino (5.12km)
          FactoryGirl.create(:property, :apartment,    :sell, zip_code: '006', lng: 13.4236807, lat: 52.5342963, price: 1000) # Berlin location
          PropertyRepository.new.import_all!
        end

        it { expect(subject.status).to eql(200)              }
        it { expect(JSON.parse(subject.body).count).to eq(1) }

        it "should format the response" do
          expect(JSON.parse(subject.body).first).to eq({
            "house_number" => "123",
            "street"       => "Street address",
            "city"         => "Sorocaba",
            "zip_code"     => "004",
            "lat"          => "-47.470245",
            "lng"          => "-23.505449",
            "price"        => "1000.0"
          })
        end
      end
    end
  end
end