module Wowr
  module Armory
    module Character
      module BaseStats
        # = Intellect
        #
        # Represents a <tt>baseStats/intellect</tt> element
        #
        # == Relevant XML example:
        #
        #   <intellect base="163" critHitPercent="14.80" effective="2176" mana="32360" petBonus="653"/>
        class Intellect
          # Character's base Intellect stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Intellect, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Amount of Mana given by this amount of Intellect
          # @return [Integer]
          attr_reader :mana

          # Critical hit chance given by this amount of Intellect
          # @return [Integer]
          attr_reader :crit_hit_percent

          # @todo Unknown purpose
          # @return [Integer]
          attr_reader :pet_bonus

          # @param [Hpricot::Elem] elem <tt>intellect</tt> element
          def initialize(elem)
            @base             = elem[:base].to_i
            @effective        = elem[:effective].to_i
            @mana             = elem[:mana].to_i
            @crit_hit_percent = elem[:critHitPercent].to_f
            @pet_bonus        = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
