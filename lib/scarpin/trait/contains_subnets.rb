module Scarpin
  module Trait
    module ContainsSubnets
      def subnet_hashes
        api.array_of(data.dig(root,'Subnets','Subnet'))
      end

      def has_subnets?
        subnet_hashes.size > 0
      end

      def subnet_ids
        subnet_hashes.map {|net| net['ID'] }
      end

      def subnets
        subnet_ids.map {|net_id| Scarpin::Resource::Subnet.fetch(api, net_id) }
      end
    end
  end
end
