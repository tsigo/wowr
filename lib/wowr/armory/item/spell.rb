module Wowr
  module Armory
    module Item
      # = Spell
      #
      # Represents an item's <tt>spell</tt> element
      #
      # == Relevant XML Example:
      #
      #   <spell>
      #     <trigger>6</trigger>
      #     <desc>Teaches you how to summon this mount.  This is a very fast mount.</desc>
      #   </spell>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-tooltip.xml?i=45725
      # * http://www.wowarmory.com/item-tooltip.xml?i=50818
      # * http://www.wowarmory.com/item-tooltip.xml?i=49177
      class Spell
        # @return [Integer]
        attr_reader :trigger

        # @return [String]
        attr_reader :description

        alias_method :desc, :description
        alias_method :to_s, :description

        # @param [Hpricot::Elem] elem <tt>spell</tt> element
        def initialize(elem)
          @trigger     = (elem%'trigger').inner_text.to_i
          @description = (elem%'desc').inner_text
        end
      end
    end
  end
end
