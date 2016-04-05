module Scarpin
  module Type
    class Interface
      attr_reader :data, :api
      def self.fetch(api, host_id, interface_name)
        target=['data','computer','id',host_id,'interface',interface_name]
        Interface.new(api.get(target), api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig('Interface','ID')
      end

      def host_id
        @host_id ||= url.split('/')[-3]
      end

      def host
        @host ||= Scarpin::Type::Host.fetch(api,host_id)
      end

      def url
        data.dig('Interface','URL')
      end

      def name
        data.dig('Interface','Name')
      end

      def address
        data.dig('Interface','Address')
      end

      def mask
        data.dig('Interface','Mask')
      end

      def vrf
        data.dig('Interface','VRF')
      end

      def comments
        data.dig('Interface','Comments')
      end

      def subnet
        Scarpin::Type::Subnet.fetch(api,data.dig('Interface','Subnet','ID'))
      end

    end
  end
end
