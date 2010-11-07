module Wowr
  module Armory
    module Character
      module BaseStats
        # = Stamina
        #
        # Represents a <tt>baseStats/stamina</tt> element
        #
        # == Relevant XML example:
        #
        #   <stamina base="129" effective="2613" health="25950" petBonus="784"/>
        class Stamina
          # Character's base Stamina stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Stamina, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Amount of health given by this amount of Stamina
          # @return [Integer]
          attr_reader :health

          # Amount of health given to the character's pet by this amount of Stamina
          # @return [Integer]
          attr_reader :pet_bonus

          # @param [Hpricot::Elem] elem <tt>stamina</tt> element
          def initialize(elem)
            @base       = elem[:base].to_i
            @effective  = elem[:effective].to_i
            @health     = elem[:health].to_i
            @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
