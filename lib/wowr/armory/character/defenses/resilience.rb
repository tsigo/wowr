module Wowr
  module Armory
    module Character
      module Defenses
        # = Resilience
        #
        # Represents a <tt>defenses/resilience</tt> element
        #
        # == Relevant XML example:
        #
        #   <resilience damagePercent="0" hitPercent="0" value="0.00"/>
        #
        # @note It appears that the Armory is currently bugged and is always reporting 0 for all values.
        #   See http://www.wowarmory.com/character-sheet.xml?r=Dragonmaw&n=Jordons
        class Resilience
          # @return [Float]
          attr_reader :damage_percent

          # @return [Float]
          attr_reader :hit_percent

          # @return [Float]
          attr_reader :value

          def initialize(elem)
            @damage_percent = elem[:damagePercent].to_f
            @hit_percent    = elem[:hitPercent].to_f
            @value          = elem[:value].to_f
          end
        end
      end
    end
  end
end
