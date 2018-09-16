require './spec/spec_helper'

describe PropertyRepository, elasticsearch: true do

  after(:all) do
    $elastic_client.indices.delete(index: '_all')
    PropertyRepository.create_index!
  end

  describe '.import_all!' do
    subject { PropertyRepository.new.search(query: { match_all: {} }).count }

    context 'when does not exists property records' do
      before { PropertyRepository.new.import_all! }
      it { should eq(0) }
    end

    context 'when exists property records' do
      before do
        FactoryGirl.create(:property, :rent)
        FactoryGirl.create(:property, :sell)
        FactoryGirl.create(:property, :family_house)
        FactoryGirl.create(:property, :apartment)
        PropertyRepository.new.import_all!
      end

      it { should eq(4) }
    end
  end

  describe '.similar' do
    subject { PropertyRepository.new.similar(request)   }
    let(:request) { Requests::Property::Get.new(params) }

    context 'when does not exists similar properties' do
      before do
        FactoryGirl.create(:property, :family_house, :rent, zip_code: '001', lng: -23.528874, lat: -47.466840) # beer caps (searching point!)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '002', lng: -23.527678, lat: -47.468569) # jack pub  (2km)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '003', lng: -23.568083, lat: -47.459705) # cervejaria bamberg (4.49km)
        FactoryGirl.create(:property, :apartment,    :rent, zip_code: '004', lng: -23.505449, lat: -47.470245) # the crown pub (2.48km)
        FactoryGirl.create(:property, :family_house, :rent, zip_code: '005', lng: -23.495320, lat: -47.435167) # bardolino (5.12km)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '006', lng: 13.4236807, lat: 52.5342963) # Berlin location
        PropertyRepository.new.import_all!
      end

      let(:params) do
        {
          lng: 13.4236807,
          lat: 52.5342963,
          property_type: 'apartment',
          marketing_type: 'sell'
        }
      end

      it { expect(subject.count).to eq(1) }
    end

    context 'when exists similar properties' do
      before do
        FactoryGirl.create(:property, :family_house, :rent, zip_code: '001', lng: -23.528874, lat: -47.466840) # beer caps (searching point!)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '002', lng: -23.527678, lat: -47.468569) # jack pub  (2km)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '003', lng: -23.568083, lat: -47.459705) # cervejaria bamberg (4.49km)
        FactoryGirl.create(:property, :apartment,    :rent, zip_code: '004', lng: -23.505449, lat: -47.470245) # the crown pub (2.48km)
        FactoryGirl.create(:property, :family_house, :rent, zip_code: '005', lng: -23.495320, lat: -47.435167) # bardolino (5.12km)
        FactoryGirl.create(:property, :apartment,    :sell, zip_code: '006', lng: 13.4236807, lat: 52.5342963) # Berlin location
        PropertyRepository.new.import_all!
      end

      let(:params) do
        {
          lng: -23.528874,
          lat: -47.466840,
          property_type: 'apartment',
          marketing_type: 'sell'
        }
      end

      it "should return the matched results" do
        expect(subject.results.count).to eq(2)
      end

      it "should include locations in 5km radius" do
        zipcodes = subject.results.collect(&:zip_code)
        expect(zipcodes).to include("002")
        expect(zipcodes).to include("003")
      end

      it "should not include near family houses" do
        zipcodes = subject.results.collect(&:zip_code)
        expect(zipcodes).not_to include("001")
      end

      it "should not include near properties for rent" do
        zipcodes = subject.results.collect(&:zip_code)
        expect(zipcodes).not_to include("004")
      end

      it "should not include locations that are not in 5km radius" do
        zipcodes = subject.results.collect(&:zip_code)
        expect(zipcodes).not_to include("005")
        expect(zipcodes).not_to include("006")
      end
    end
  end
end
