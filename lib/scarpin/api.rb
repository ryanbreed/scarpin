module Scarpin
  class Api
    include Helpers
    attr_accessor :host, :port, :user, :pass

    def initialize(*args)
      Hash[*args].each { |k, v| send(format('%s=', k), v) }
      @port ||= 443
    end

    def xml
      @xml ||= Nori.new
    end

    def build_request(path: 'data', payload: {}, method: :get)
      requested_path = sanipath(*path)
      RestClient::Request.new(method: method,
                              url: uri(requested_path),
                              user: user,
                              password: pass,
                              read_timeout: 10,
                              verify_ssl: OpenSSL::SSL::VERIFY_NONE,
                              payload: payload,
                              headers: { accept: 'application/x-RedSealv8.0+xml' })
    end

    def get(path='data/group/Topoplogy', parse: :as_hash)
      request(path: path, method: :get, parse: parse)
    end

    def request(path: 'data', payload: {}, method: :get, parse: :as_hash)
      req = build_request(path: path, payload: payload, method: method)
      result = req.execute
      if self.respond_to?(parse)
        self.send(parse,result)
      else
        result
      end
    end

    def as_hash(response)
      xml.parse(response)
    end

    def as_xml(response)
      Nokogiri::XML(response, nil, nil, xml_parse_options).extend(Scarpin::XmlEntity)
    end

    def uri(path = 'data')
      format('https://%s:%d/%s', host, port, URI.escape(path))
    end

    private

    def xml_parse_options
      Nokogiri::XML::ParseOptions::NOBLANKS | Nokogiri::XML::ParseOptions::DEFAULT_XML
    end

  end
end
