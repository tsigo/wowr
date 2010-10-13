module Wowr
  module Armory
    module Item
      class Vendor
        attr_reader :id, :name, :title, :type,
          :area, :classification, :max_level, :min_level
        alias_method :to_s, :name
        alias_method :to_i, :id

        def initialize(elem)
          @id             = elem[:id].to_i
          @name           = elem[:name]
          @title          = elem[:title]
          @type           = elem[:type]
          @area           = elem[:area]
          @classification = elem[:classification].to_i
          @max_level      = elem[:maxLevel].to_i
          @min_level      = elem[:minLevel].to_i
        end
      end
    end
  end
end
