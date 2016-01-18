require 'spec_helper'
describe 'Scarpin::Api' do
  let(:api) { Scarpin::Api.new(user: 'spec_user', pass: 'spec_pass', host: 'spec_host') }
  describe '.initialize' do
    it 'initializes from keyword args' do
      expect(api).to be_a(Scarpin::Api)
      expect(api.user).to eq('spec_user')
      expect(api.pass).to eq('spec_pass')
      expect(api.host).to eq('spec_host')
      expect(api.port).to eq(443)
    end
  end

  describe '#xml' do
    it 'holds a Nori parser' do
      expect(api.xml).to be_a(Nori)
    end
  end

  describe '#parse' do
    let(:data_result) { File.read('spec/fixtures/data_result.xml') }
    let(:parsed) { api.parse(data_result) }
    it 'returns a hash' do
      expect(parsed).to be_a(Nokogiri::XML::Document)
    end
  end

  describe '#uri' do
    it 'formats a request path to be the full url' do
      expect(api.uri('data/access')).to eq('https://spec_host:443/data/access')
    end
    it 'CGI escapes path names' do
      expect(api.uri('data/with space')).to eq('https://spec_host:443/data/with%20space')
    end
  end

  describe '#build_request' do
    let(:req) do
      api.build_request(path: 'data/access',
                        method: :put,
                        payload: { foo: :bar })
    end

    it 'returns a RestClient Request' do
      expect(req).to be_a(RestClient::Request)
    end

    it 'sets the accept header' do
      expect(req.headers).to include(accept: 'application/x-RedSealv8.0+xml')
    end

    it 'sets the request url' do
      expect(req.url).to eq('https://spec_host:443/data/access')
    end

    it 'sets the request method' do
      expect(req.method).to eq(:put)
    end

    it 'sets the payload' do
      expect(req.payload).to be_a_kind_of(RestClient::Payload::Base)
    end
  end
end
