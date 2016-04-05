module Scarpin
  module Resource
    class Host
      ROOT = 'Host'

      def root
        ROOT
      end

      attr_reader :data, :api

      include Scarpin::Trait::ContainsInterfaces

      def self.fetch(api, host_id)
        target=['data/host/id',host_id]
        Host.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig(root,'TreeId')
      end

      def url
        data.dig(root,'URL')
      end

      def name
        data.dig(root,'Name')
      end

      def operating_system
        data.dig(root,'OperatingSystem')
      end

      def os
        operating_system
      end

      def os_version
        data.dig(root,'OSVersion')
      end

      def os_vendor
        data.dig(root,'OSVendor')
      end

      def type
        data.dig(root,'Type')
      end
    end
  end
end