require "scarpin/version"

module Scarpin
  def self.configure(config_file = File.join(ENV['HOME'],'.scarpin.json'))
    configuration = JSON.parse(File.read(config_file))
    Api.new(configuration)
  end

  class Api
    attr_accessor :host, :port, :user, :pass

    def initialize(*args)
      Hash[*args].each {|k,v| self.send(format('%s=',k),v)}
      @port ||= 443

    end

    def xml
      @xml ||= Nori.new
    end

    def build_request(path: nil, payload: {}, method: nil)
      RestClient::Request.new( method: method,
                               url: uri(path),
                               user: user,
                               password: pass,
                               read_timeout: 10,
                               verify_ssl: OpenSSL::SSL::VERIFY_NONE,
                               payload: payload,
                               headers: { accept: 'application/x-RedSealv8.0+xml' } )
    end

    def request(path: 'data', payload: {}, method: :get, parse: true)
      req = build_request(path: path, payload: payload, method: method)
      begin
        result = req.execute
        parse ? parse_result(result) : result
      rescue Exception => e
        STDERR.puts e.to_s
        STDERR.puts format('failed to %s %s', method, path)
        STDERR.puts payload
        {}
      end
    end

    def parse_result(response)
      xml.parse(response)
    end

    def uri(path='data')
      sprintf('https://%s:%d/%s', host, port, URI.escape(path))
    end

  end
end
