require 'spec_helper'

include Scarpin::Helpers

describe Scarpin::Helpers do
  describe '#unqualified' do
    it 'returns the host portion of a fqdn' do
      hname='host.domain.tld'
      expect(unqualified(hname)).to eq('host') 
    end

    it 'downcases the host portion of a fqdn' do
      hname='DOWNCASEME.domain.tld'
      expect(unqualified(hname)).to eq('downcaseme') 
    end

    it 'returns the bare hostname for unqualified input' do
      hname='unqualified'
      expect(unqualified(hname)).to eq('unqualified') 
    end
    
    it 'handles nils'
    it 'handles empty strings'
  end 
  
  describe '#sanipath' do
    it 'joins uri path pieces' do
      pieces=%w{ path on url }
      expect(sanipath(*pieces)).to eq('path/on/url')
    end

    it 'strips leading or trailing slashes' do
      pieces=%w{ path /on url/ }
      expect(sanipath(*pieces)).to eq('path/on/url')
    end

    it 'expands and cleans embedded path components' do
      pieces=%w{ path in/the//middle url }
      expect(sanipath(*pieces)).to eq('path/in/the/middle/url')
    end
  end
end
