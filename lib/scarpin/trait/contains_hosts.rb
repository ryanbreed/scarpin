module Scarpin
  module Trait
    module ContainsHosts
      def host_hashes
        if data.dig(root).key?('Computers')
          self.computer_host_hashes
        else
          api.array_of(data.dig(root,'Hosts','Host'))
        end
      end

      def has_hosts?
        host_hashes.size > 0
      end

      def host_ids
        host_hashes.map {|host| host['TreeId'] }
      end

      def hosts
        host_ids.map {|host_id| Scarpin::Resource::Host.fetch(api, host_id)}
      end
    end
  end
end
