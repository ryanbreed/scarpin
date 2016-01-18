module Scarpin
  module Helpers
    def array_of(thing)
      case thing
      when Hash, String
        [thing]
      when Array
        thing
      else
        []
      end
    end

    def unqualified(hostname)
      if hostname.nil? || hostname.split('.')[0].nil?
        nil
      elsif hostname =~ /\A[0-9]+\./
        hostname
      else
        uq = hostname.split('.')[0]
        uq.nil? ? nil : uq.downcase
      end
    end

    def sanipath(*parts)
      cleaned = parts.flat_map { |p| p.to_s.gsub(%r{(\A/|/\z)}, '').split('/') }
      cleaned.reject { |c| c == '' || c.nil? }.join('/')
    end

    def saniparts(*parts)
      cleaned = sanipath(*parts)
      cleaned.split('/')
    end
  end
end
