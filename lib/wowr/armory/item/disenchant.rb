module Wowr
  module Armory
    module Item
      # = Disenchant
      #
      # Represents an <tt>item</tt> element in a <tt>disenchantLoot</tt> element
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

        # @see Wowr::Armory#quality
        # @return [Integer]
        attr_reader :quality

        # @param [Hpricot::Elem] elem <tt>item</tt> element
        # @param [Wowr::API::API] api
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
