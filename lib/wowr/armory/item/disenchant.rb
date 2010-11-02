module Wowr
  module Armory
    module Item
      # Represents an <tt><item></tt> element in a <tt><disenchantLoot></tt> element
      #
      # == Relevant XML example:
      #
      #   <item canAuction="1" dropRate="6" icon="inv_enchant_abysscrystal" id="34057" level="80" maxCount="1" minCount="1" name="Abyss Crystal" quality="4" type="Enchanting"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=40395
      class Disenchant < Wowr::Armory::Item::Base
        # @return [Integer]
        attr_reader :level

        # @example
        #   "Enchanting"
        # @return [String]
        attr_reader :type

        # @return [Integer]
        attr_reader :drop_rate

        # Minimum number of this item from disenchanting
        # @return [Integer]
        attr_reader :min_count

        # Maximum number of this item from disenchanting
        # @return [Integer]
        attr_reader :max_count

        # Item rarity (quality)
        # * 0 - Trash (Grey)
        # * 1 - Common (White)
        # * 2 - Uncommon (Green)
        # * 3 - Rare (Blue)
        # * 4 - Epic (Purple)
        # * 5 - Legendary (Orange)
        # * 6
        # * 7 - Heirloom (Gold)
        # @return [Integer]
        attr_reader :quality

        def initialize(elem, api = nil)
          super(elem, api)

          @level      = elem[:level].to_i
          @type       = elem[:type]
          @drop_rate  = elem[:dropRate].to_i
          @min_count  = elem[:minCount].to_i
          @max_count  = elem[:maxCount].to_i
          @quality    = elem[:quality].to_i
        end
      end
    end
  end
end
