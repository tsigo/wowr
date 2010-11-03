module Wowr
  module Armory
    module Item
      # Represents a <tt><damageData></tt> element
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
        # Damage type:
        # * 0 - Physical
        # * 1 - Holy
        # * 2 - Fire
        # * 3 - Nature
        # * 4 - Frost
        # * 5 - Shadow
        # * 6 - Arcane
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

        def initialize(elem)
          @type   = (elem%'damage'%'type').html.to_i
          @min    = (elem%'damage'%'min').html.to_i
          @max    = (elem%'damage'%'max').html.to_i
          @speed  = (elem%'speed').html.to_f  if (elem%'speed')
          @dps    = (elem%'dps').html.to_f    if (elem%'dps')
        end
      end
    end
  end
end
