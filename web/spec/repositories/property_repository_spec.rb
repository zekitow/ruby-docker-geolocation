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
        FactoryGirl.create(:property, :for_rent)
        FactoryGirl.create(:property, :to_sell)
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

    before do
      FactoryGirl.create(:property, :for_rent)
      FactoryGirl.create(:property, :to_sell)
      FactoryGirl.create(:property, :family_house)
      FactoryGirl.create(:property, :apartment)
      FactoryGirl.create(:property, :apartment)
      FactoryGirl.create(:property, :apartment, :to_sell, lng: 13.4236807, lat: 52.5342963)
      PropertyRepository.new.import_all!
    end

    context 'when does not exists similar properties' do
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
    end
  end
end
