module Scarpin
  module Resource
    class Group
      ROOT = 'FullGroup'
      def root
        ROOT
      end

      attr_reader :data, :api

      include Scarpin::Trait::ContainsSubnets,
              Scarpin::Trait::ContainsGroups,
              Scarpin::Trait::ContainsHosts,
              Scarpin::Trait::ContainsDevices,
              Scarpin::Trait::ContainsComputers

      def self.fetch(api, full_path)
        Group.new(api.get(full_path), api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def path
        api.sanipath('data','group',CGI.unescape(data.dig(root,'Path')))
      end

      def url
        data.dig(root,'URL')
      end

      def name
        data.dig(root,'Name')
      end

    end
  end
end
