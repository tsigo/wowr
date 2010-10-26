module Wowr
  module Armory
    module Item
      # Represents a spell description for an item
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
        # Spell trigger
        # @return [Integer]
        attr_reader :trigger

        # Spell description
        # @return [String]
        attr_reader :description

        alias_method :desc, :description
        alias_method :to_s, :description

        # @param [Hpricot::Elem] elem <tt><spell></tt> element
        def initialize(elem)
          @trigger = (elem%'trigger').html.to_i
          @description = (elem%'desc').html
        end
      end
    end
  end
end
