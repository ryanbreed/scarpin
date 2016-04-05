module Scarpin
  module Type
    class Subnet
      attr_reader :data, :api
      def self.fetch(api, subnet_id)
        target = ['data/subnet/id', subnet_id]
        Subnet.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig('Subnet','ID')
      end

      def wireless
        data.dig('Subnet','Wireless')
      end

      def unnumbered?
        data.dig('Subnet','Unnumbered')
      end

      def mask
        data.dig('Subnet','Mask')
      end

      def url
        data.dig('Subnet','URL')
      end

      def name
        data.dig('Subnet','Name')
      end

      def cidr
        data.dig('Subnet','CIDR')
      end

      def trust
        data.dig('Subnet','TrustLevel')
      end

      def description
        data.dig('Subnet','Description')
      end

    end
  end
end
