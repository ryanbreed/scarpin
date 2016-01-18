module Scarpin
  module XmlEntity
    def entity_type
      self.element_children.first.node_name
    end
    
    def entity_attribute_names
      self.element_children.first.children.select {|c| c.element_children.size == 0 }.map(&:name)
    end

    def entity_attribute_paths
      entity_attribute_names.map { |n| format('/%s/%s',entity_type, n) }
    end

    def entity_attribute_values
      entity_attribute_paths.map { |p| self.xpath(p).text }
    end

    def entity_hash
      Hash[entity_attribute_names.zip(entity_attribute_values)]
    end

    def entity_relation_names
      self.element_children.first.children.select {|c| c.element_children.size > 0 }.map(&:name)
    end
    
    def entity_relation_paths
      entity_relation_names.map { |n| format('/%s/%s',entity_type, n) }
    end
  end
end
