require './spec/spec_helper'
require './spec/shared_examples'

describe Property, type: :model do

  describe 'attributes' do
    it { is_expected.to respond_to(:offer_type)        }
    it { is_expected.to respond_to(:property_type)     }
    it { is_expected.to respond_to(:zip_code)          }
    it { is_expected.to respond_to(:city)              }
    it { is_expected.to respond_to(:street)            }
    it { is_expected.to respond_to(:house_number)      }
    it { is_expected.to respond_to(:lng)               }
    it { is_expected.to respond_to(:lat)               }
    it { is_expected.to respond_to(:construction_year) }
    it { is_expected.to respond_to(:number_of_rooms)   }
    it { is_expected.to respond_to(:currency)          }
    it { is_expected.to respond_to(:price)             }
  end

  context 'validations' do
    subject { Property.new(model_attributes).valid? }

    let!(:model_attributes) do
      {
        offer_type: "sell",
        property_type: "apartment",
        street: "Street address",
        house_number: "123",
        zip_code: "18044-000",
        city: "Sorocaba",
        lng: -23.506270,
        lat: -47.455630
      }
    end

    context 'without required attributes' do
      it_should_behave_like "model without required attribute", Property, "offer_type"
      it_should_behave_like "model without required attribute", Property, "property_type"
      it_should_behave_like "model without required attribute", Property, "street"
      it_should_behave_like "model without required attribute", Property, "house_number"
      it_should_behave_like "model without required attribute", Property, "lng"
      it_should_behave_like "model without required attribute", Property, "lat"
      it_should_behave_like "model without required attribute", Property, "zip_code"
      it_should_behave_like "model without required attribute", Property, "city"
    end

    context 'with required attribute' do
      it { should be true }
    end
  end

  context '.to_hash' do
    subject { Property.new(attributes).to_hash }
    let!(:attributes) do
      {
        offer_type: Property.offer_types[:sell],
        property_type: Property.property_types[:apartment],
        street: "Street address",
        house_number: "123",
        zip_code: "18044-000",
        city: "Sorocaba",
        lng: -23.506270,
        lat: -47.455630
      }
    end

    it { expect(subject[:offer_type]).to eq("sell")         }
    it { expect(subject[:property_type]).to eq("apartment") }
    it { expect(subject[:street]).to eq("Street address")   }
    it { expect(subject[:house_number]).to eq("123")        }
    it { expect(subject[:zip_code]).to eq("18044-000")      }
    it { expect(subject[:city]).to eq("Sorocaba")           }
    it { expect(subject[:lng]).to eq(-23.506270)            }
    it { expect(subject[:lat]).to eq(-47.455630)            }
  end
end
