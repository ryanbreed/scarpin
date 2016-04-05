module Scarpin
  module Type
    class Subnet
      ROOT = 'Subnet'

      def root
        ROOT
      end

      attr_reader :data, :api

      def self.fetch(api, subnet_id)
        target = ['data/subnet/id', subnet_id]
        Subnet.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig(root,'ID')
      end

      def wireless
        data.dig(root,'Wireless')
      end

      def unnumbered?
        data.dig(root,'Unnumbered')
      end

      def mask
        data.dig(root,'Mask')
      end

      def url
        data.dig(root,'URL')
      end

      def name
        data.dig(root,'Name')
      end

      def cidr
        data.dig(root,'CIDR')
      end

      def trust
        data.dig(root,'TrustLevel')
      end

      def description
        data.dig(root,'Description')
      end

      def device_hashes
        api.array_of(data.dig(root,'Devices','Device'))
      end

      def devices
        device_hashes.map {|dev| Scarpin::Type::Device.fetch(api, dev['TreeId'])}
      end

      def host_hashes
        api.array_of(data.dig(root,'Hosts','Host'))
      end

      def hosts
        host_hashes.map {|host| Scarpin::Type::Host.fetch(api, host['TreeId'])}
      end

    end
  end
end
