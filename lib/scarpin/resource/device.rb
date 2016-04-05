module Scarpin
  module Resource
    class Device
      ROOT = 'Device'

      def root
        ROOT
      end

      attr_reader :data, :api

      include Scarpin::Trait::ContainsInterfaces
      
      def self.fetch(api,id)
        target = ['data/device/id',id]
        Device.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def config_hashes
        @config_hashes ||= api.array_of(data.dig(root,'Configuration'))
      end

      def config_filenames
        config_hashes.map {|cf| cf['Name']}
      end

      def configs
        config_filenames.map {|fname| Scarpin::Resource::Config.fetch(api,self.id,fname)}
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

      def primary_capability
        data.dig(root,'PrimaryCapability')
      end

      def type
        primary_capability
      end
    end
  end
end
