module Scarpin
  module Trait
    module ContainsInterfaces
      def interface_hashes
        api.array_of(data.dig(root,'Interfaces','Interface'))
      end

      def has_interfaces?
        interface_hashes.size > 0
      end

      def interface_addresses
        interface_hashes.map {|intf| intf['Address']}.sort.uniq
      end

      def interfaces
        interface_addresses.map {|addr| Scarpin::Resource::Interface.fetch(api, self.id, addr) }
      end
    end
  end
end
