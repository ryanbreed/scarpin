module Scarpin
  module Type
    class Config
      attr_reader :data, :api
      def self.fetch(api,device_id,file_name)
        target=['data/device/id',device_id,'configuration',file_name]
        Config.new(api.get(target),api)
      end

      def initialize(hashdata,api)
        @data,@api=hashdata,api
      end

      def id
        data.dig('Configuration','TreeId')
      end

      def name
        data.dig('Configuration','Name')
      end

      def file_name
        name
      end

      def url
        data.dig('Configuration','URL')
      end

      def lines
        api.array_of(data.dig('Configuration','FileLine')).map {|line| line.fetch('Text')}
      end
    end
  end
end
