require 'spec_helper'

describe Scarpin do
  it 'has a version number' do
    expect(Scarpin::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'returns a configured Api instance when given a filename' do
      api = Scarpin.configure('spec/fixtures/scarpin_api_spec.json')
      expect(api).to be_a(Scarpin::Api)
      expect(api.user).to eq('spec_user')
      expect(api.pass).to eq('spec_pass')
      expect(api.host).to eq('spec_host')
      expect(api.port).to eq(443)
    end
  end
end
