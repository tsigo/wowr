module Wowr
  module Armory
    module Item
      # = EquipData
      #
      # Represents an <tt>equipData</tt> element
      #
      # == Relevant XML example:
      #
      #   <equipData>
      #     <inventoryType>18</inventoryType>
      #     <containerSlots>22</containerSlots>
      #     <subclassName>Bag</subclassName>
      #   </equipData>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-tooltip.xml?i=40395
      # * http://www.wowarmory.com/item-tooltip.xml?i=49295
      class EquipData
        # @return [Integer]
        attr_reader :inventory_type

        # @example
        #   "Bag"
        #   "Mace"
        # @return [String]
        attr_reader :subclass_name

        # For bags, the number of slots
        # @return [Integer]
        attr_reader :container_slots

        # @param [Hpricot::Elem] elem <tt>equipData</tt> element
        def initialize(elem)
          @inventory_type  = (elem%'inventoryType').inner_text.to_i
          @subclass_name   = (elem%'subclassName').inner_text        if (elem%'subclassName')
          @container_slots = (elem%'containerSlots').inner_text.to_i if (elem%'containerSlots')
        end
      end
    end
  end
end
