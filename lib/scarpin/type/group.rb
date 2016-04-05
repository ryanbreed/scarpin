module Scarpin
  module Type
    class Group
      ROOT = 'FullGroup'
      def root
        ROOT
      end
      
      attr_reader :data, :api
      def self.fetch(api,path='data/group/Topology')
        Group.new(api.get(path),api)
      end
      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def path
        api.sanipath('data','group',data.dig('FullGroup','Path'))
      end

      def url
        data.dig('FullGroup','URL')
      end

      def name
        data.dig('FullGroup','Name')
      end

      def subgroups
        group_summaries = api.array_of(data.dig('FullGroup','Groups','Group'))
        group_summaries.map { |sg| Group.fetch(api,api.sanipath('data','group',sg['Path'])) }
      end

      def subnets
        subnet_summaries = api.array_of(data.dig('FullGroup','Subnets','Subnet'))
        subnet_summaries.map { |net| Scarpin::Type::Subnet.fetch(api,net['ID']) }
      end

      def has_subgroups?
        subgroups.size > 0
      end

      def expand_subgroups
        if has_subgroups?
          subgroups.flat_map {|sg| sg.expand_subgroups}
        else
          self
        end
      end
    end
  end
end
