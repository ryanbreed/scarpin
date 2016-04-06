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

      def expand(full: true)
        if has_groups?
          if full # include ourself in the expanded list
            [self, groups.flat_map {|subgroup| subgroup.expand(full: full) }].flatten
          else
            groups.flat_map {|subgroup| subgroup.expand(full: full) }
          end
        else
          self
        end
      end
    end
  end
end
