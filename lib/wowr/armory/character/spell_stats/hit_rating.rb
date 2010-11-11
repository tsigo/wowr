module Wowr
  module Armory
    module Character
      module SpellStats
        # = HitRating
        #
        # Represents a <tt>hitRating</tt> element inside a <tt>spell</tt>
        # element
        #
        # == Relevant XML example:
        #
        #   <hitRating increasedHitPercent="17.00" penetration="0" reducedResist="0" value="446"/>
        class HitRating
          # @return [Float]
          attr_reader :increased_hit_percent

          # @return [Integer]
          attr_reader :penetration

          # @return [Integer]
          attr_reader :reduced_resist

          # @return [Integer]
          attr_reader :value

          # @param [Hpricot::Elem] elem <tt>hitRating</tt> element
          def initialize(elem)
            @increased_hit_percent = elem[:increasedHitPercent].to_f
            @penetration           = elem[:penetration].to_i
            @reduced_resist        = elem[:reducedResist].to_i
            @value                 = elem[:value].to_i
          end
        end
      end
    end
  end
end
