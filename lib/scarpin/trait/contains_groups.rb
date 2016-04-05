module Scarpin
  module Trait
    module ContainsGroups
      def group_hashes
        api.array_of(data.dig(root,'Groups','Group'))
      end

      def has_groups?
        group_hashes.size > 0
      end

      def group_paths
        group_hashes.map {|grp| format('data/group%s',CGI.unescape(grp['Path']) )}
      end

      def groups
        group_paths.map {|path| Scarpin::Resource::Group.fetch(api, path)}
      end

      def expand_groups
        if has_groups?
          groups.flat_map {|subgroup| subgroup.expand_groups }
        else
          self
        end
      end
    end
  end
end
