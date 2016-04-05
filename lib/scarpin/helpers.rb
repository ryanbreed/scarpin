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
      base_parts = parts.flat_map {|p| p.split('/')}
      escaped_parts = base_parts.map {|p| CGI.escape(p)}
      path_part = URI.parse(escaped_parts.join('/')).path
      cleaned_path = path_part.split('/').reject(&:empty?).join('/')
      cleaned_path
    end

    def saniparts(*parts)
      cleaned = sanipath(*parts)
      cleaned.split('/')
    end
  end
end
