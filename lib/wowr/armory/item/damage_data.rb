module Wowr
  module Armory
    module Item
      # = DamageData
      #
      # Represents a <tt>damageData</tt> element
      #
      # == Relevant XML example:
      #
      #   <damageData>
      #     <damage>
      #       <type>0</type>
      #       <min>886</min>
      #       <max>1329</max>
      #     </damage>
      #     <speed>3.4</speed>
      #     <dps>325.74</dps>
      #   </damageData>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-tooltip.xml?i=20672
      # * http://www.wowarmory.com/item-tooltip.xml?i=28783
      # * http://www.wowarmory.com/item-tooltip.xml?i=32837
      # * http://www.wowarmory.com/item-tooltip.xml?i=40395
      # * http://www.wowarmory.com/item-tooltip.xml?i=50727
      # * http://www.wowarmory.com/item-tooltip.xml?i=50733
      class DamageData
        # @see Wowr::Armory#damage_type
        # @return [Integer]
        attr_reader :type

        # @return [Integer]
        attr_reader :min

        # @return [Integer]
        attr_reader :max

        # @return [Float]
        attr_reader :speed

        # @return [Float]
        attr_reader :dps

        # @param [Hpricot::Elem] elem <tt>damageData</tt> element
        def initialize(elem)
          @type   = elem.search('damage/type').inner_text.to_i
          @min    = elem.search('damage/min').inner_text.to_i
          @max    = elem.search('damage/max').inner_text.to_i
          @speed  = (elem%'speed').inner_text.to_f if (elem%'speed')
          @dps    = (elem%'dps').inner_text.to_f   if (elem%'dps')
        end
      end
    end
  end
end
