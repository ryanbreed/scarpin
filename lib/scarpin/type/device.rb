module Scarpin
  module Type
    class Device
      attr_reader :data, :api
      def self.fetch(api,id)
        target = ['data/device/id',id]
        Device.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def config_hashes
        @config_hashes ||= api.array_of(data.dig('Device','Configuration'))
      end

      def config_filenames
        config_hashes.map {|cf| cf['Name']}
      end

      def configs
        config_filenames.map {|fname| Scarpin::Type::Config.fetch(api,self.id,fname)}
      end

      def interface_hashes
        @interface_hashes ||= api.array_of(data.dig('Device','Interfaces','Interface'))
      end

      def interface_addresses
        interface_hashes.map {|intf| intf['Address']}.sort.uniq
      end

      def interfaces
        interface_addresses.map {|addr| Scarpin::Type::Interface.fetch(api, self.id, addr) }
      end

      def id
        data.dig('Device','TreeId')
      end

      def url
        data.dig('Device','URL')
      end

      def name
        data.dig('Device','Name')
      end

      def operating_system
        data.dig('Device','OperatingSystem')
      end

      def os
        operating_system
      end

      def primary_capability
        data.dig('Device','PrimaryCapability')
      end

      def type
        primary_capability
      end
    end
  end
end
