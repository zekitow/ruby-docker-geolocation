require './spec/spec_helper'

describe Requests::Property::Get do
  subject { Requests::Property::Get.new(params) }

  context 'when params are invalid' do
    let(:params) { { }             }
    before       { subject.valid?  }

    it { expect(subject.valid?).to eq(false) }
    it { expect(subject.errors.messages[:lng]).to eq(["can't be blank"]) }
    it { expect(subject.errors.messages[:lat]).to eq(["can't be blank"]) }
    it { expect(subject.errors.messages[:property_type]).to eq(["can't be blank"]) }
    it { expect(subject.errors.messages[:marketing_type]).to eq(["can't be blank"]) }
  end

  context 'when params are valid' do
    let(:params) { fixture_as_hash("support/requests/json/requests/valid_property_request.json") }
    it { expect(subject.valid?).to eq(true) }
  end

  context 'validate!' do
    context 'when params are not sent' do
      let(:params) { {} }
      let(:expected_error_message) do
        "Lng can't be blank, " \
        "Lat can't be blank, " \
        "Property type can't be blank, " \
        "Marketing type can't be blank"
      end

      it { expect{subject.validate!}.to raise_error(BadRequestError)          }
      it { expect{subject.validate!}.to raise_error(expected_error_message)   }
    end

    context 'when params are sent' do
      context 'with valid params' do
        let(:params) { fixture_as_hash("support/requests/json/requests/valid_property_request.json") }
        it { expect{subject.validate!}.not_to raise_error }
      end
    end
  end
end