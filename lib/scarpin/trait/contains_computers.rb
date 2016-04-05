module Scarpin
  module Trait
    module ContainsComputers
      def computer_host_hashes
        api.array_of(data.dig(root,'Computers','Host'))
      end

      def has_computer_hosts?
        computer_host_hashes.size > 0
      end

      def computer_device_hashes
        api.array_of(data.dig(root,'Computers','Device'))
      end

      def has_computer_devices?
        computer_device_hashes.size > 0
      end

      def has_computers?
        has_computer_hosts? || has_computer_devices?
      end
    end
  end
end
