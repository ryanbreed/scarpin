module Scarpin
  module Type
    class Host
      attr_reader :data, :api
      def self.fetch(api, host_id)
        target=['data/host/id',host_id]
        Host.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig('Host','TreeId')
      end

      def url
        data.dig('Host','URL')
      end

      def name
        data.dig('Host','Name')
      end

      def interface_hashes
        @interface_hashes ||= api.array_of(data.dig('Host','Interfaces','Interface'))
      end

      def interface_addresses
        interface_hashes.map {|h| h['Address']}.sort.uniq
      end

      def interfaces
        interface_addresses.map {|addr| Scarpin::Type::Interface.fetch(api, self.id, addr) }
      end

      def operating_system
        data.dig('Host','OperatingSystem')
      end

      def os
        operating_system
      end

      def os_version
        data.dig('Host','OSVersion')
      end

      def os_vendor
        data.dig('Host','OSVendor')
      end

      def type
        data.dig('Host','Type')
      end
    end
  end
end
