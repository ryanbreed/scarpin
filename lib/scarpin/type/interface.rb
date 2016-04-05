module Scarpin
  module Type
    class Interface
      ROOT = 'Interface'
      def root
        ROOT
      end

      attr_reader :data, :api
      def self.fetch(api, host_id, interface_name)
        target=['data','computer','id',host_id,'interface',interface_name]
        Interface.new(api.get(target), api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig(root,'ID')
      end

      def host_id
        @host_id ||= url.split('/')[-3]
      end

      def host
        @host ||= Scarpin::Type::Host.fetch(api,host_id)
      end

      def url
        data.dig(root,'URL')
      end

      def name
        data.dig(root,'Name')
      end

      def address
        data.dig(root,'Address')
      end

      def mask
        data.dig(root,'Mask')
      end

      def vrf
        data.dig(root,'VRF')
      end

      def comments
        data.dig(root,'Comments')
      end

      def subnet
        Scarpin::Type::Subnet.fetch(api,data.dig(root,'Subnet','ID'))
      end

    end
  end
end
