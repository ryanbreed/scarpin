module Scarpin
  module Trait
    module ContainsComputers
      def computer_hashes
        api.array_of(data.dig(root,'Computers','Host'))
      end

      def has_computers?
        computer_hashes.size > 0
      end
    end
  end
end
