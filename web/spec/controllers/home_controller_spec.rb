require './spec/spec_helper'

describe HomeController do

  context 'when I am authorized' do
    context 'GET /' do
      subject { get '/', {} }

      context 'when I access the root page' do
        it { expect(subject.status).to eql(401) }
        it { expect(subject.body).to include('401') }
      end
    end
  end
end
