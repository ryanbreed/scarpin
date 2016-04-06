module Scarpin
  module Resource
    class View
      ROOT = 'View'
      def root
        ROOT
      end

      attr_reader :data, :api

      def self.fetch(api, view_name)
        target = ['data/view',view_name]
        View.new(api.get(target),api)
      end

      def self.list(api)
        api.array_of( api.get('data/view').dig('list','View') )
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def url
        data.dig(root,'URL')
      end

      def name
        data.dig(root,'Name')
      end

      def comments
        data.dig(root,'Comments')
      end

      def type
        data.dig(root,'Type')
      end

      def policy_enabled?
        data.dig(root,'PolicyEnabled')
      end

      def group
        @group ||= Scarpin::Resource::Group.fetch(api,format('data/group/%s',name))
      end

      def method_missing(meth,*args)
        if group.respond_to?(meth)
          group.send(meth,*args)
        else
          raise NoMethodError, "cannot call #{meth} on #{self.class.to_s}/#{self.name}"
        end
      end
    end
  end
end
