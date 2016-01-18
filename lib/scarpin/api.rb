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
      RestClient::Request.new(method: method,
                              url: uri(path),
                              user: user,
                              password: pass,
                              read_timeout: 10,
                              verify_ssl: OpenSSL::SSL::VERIFY_NONE,
                              payload: payload,
                              headers: { accept: 'application/x-RedSealv8.0+xml' })
    end

    def request(path: 'data', payload: {}, method: :get, return_raw: false)
      req = build_request(path: path, payload: payload, method: method)
      result = req.execute
      return_raw ? result : result_list(parse(result))
    end

    def parse(response)
      xml.parse(response)
    end

    def uri(path = 'data')
      format('https://%s:%d/%s', host, port, URI.escape(path))
    end

    def extract_result(result)
      if result.keys.size == 1
        result.fetch(result.keys[0])
      else
        result
      end
    end

    def result_list(result)
      data = extract_result(result)
      case data
      when Array
        data.map { |datum| OpenStruct.new(datum) }
      when Hash
        [OpenStruct.new(data)]
      else
        []
      end
    end
  end
end
