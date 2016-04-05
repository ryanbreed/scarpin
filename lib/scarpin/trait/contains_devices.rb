module Scarpin
  module Trait
    module ContainsDevices
      def device_hashes
        if data.dig(root).key?('Computers')
          computer_device_hashes
        else
          api.array_of(data.dig(root,'Devices','Device'))
        end
      end

      def has_devices?
        device_hashes.size > 0
      end

      def device_ids
        device_hashes.map {|dev| dev['TreeId'] }
      end

      def devices
        device_ids.map {|dev_id| Scarpin::Resource::Device.fetch(api, dev_id) }
      end
    end
  end
end
