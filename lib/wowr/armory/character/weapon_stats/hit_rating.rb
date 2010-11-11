module Wowr
  module Armory
    module Character
      module WeaponStats
        # = HitRating
        #
        # Represents a <tt>hitRating</tt> element inside a <tt>melee</tt> or
        # <tt>ranged</tt> element
        #
        # == Relevant XML example:
        #
        #   <hitRating increasedHitPercent="11.22" penetration="0" reducedArmorPercent="0.00" value="345"/>
        class HitRating
          # @return [Float]
          attr_reader :increased_hit_percent

          # @return [Float]
          attr_reader :armor_penetration

          # @return [Integer]
          attr_reader :value

          # @param [Hpricot::Elem] elem <tt>hitRating</tt> element
          def initialize(elem)
            @increased_hit_percent = elem[:increasedHitPercent].to_f
            @armor_penetration     = elem[:penetration].to_f
            @value                 = elem[:value].to_i
          end
        end
      end
    end
  end
end
