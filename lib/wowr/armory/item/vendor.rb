module Wowr
  module Armory
    module Item
      # Represents an NPC vendor which sells an item
      #
      # == Relevant XML Example:
      #
      #   <creature area="Crystalsong Forest" classification="0" heroic="1" id="28995" maxLevel="75" minLevel="75" name="Paldesse" title="Cloth Armor Merchant" type="Humanoid"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=46163
      # * http://www.wowarmory.com/item-info.xml?i=48136
      # * http://www.wowarmory.com/item-info.xml?i=45395
      class Vendor
        # Vendor ID
        # @return [Intenger]
        attr_reader :id

        # Vendor name
        # @return [String]
        attr_reader :name

        # Vendor title
        # @example "Cloth Armor Merchant"
        # @return [String]
        attr_reader :title

        # Vendor NPC type
        # @example "Humanoid"
        # @return [String]
        attr_reader :type

        # Vendor area (zone name)
        # @return [String]
        attr_reader :area

        # Vendor classification
        # @return [Intenger]
        attr_reader :classification

        # Vendor maximum level
        # @return [Intenger]
        attr_reader :max_level

        # Vendor minimum level
        # @return [Intenger]
        attr_reader :min_level

        alias_method :to_s, :name
        alias_method :to_i, :id

        # @param [Hpricot::Elem] elem <tt><creature/></tt> element
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
