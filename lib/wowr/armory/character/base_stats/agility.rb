module Wowr
  module Armory
    module Character
      module BaseStats
        # = Agility
        #
        # Represents a <tt>baseStats/agility</tt> element
        #
        # == Relevant XML example:
        #
        #   <agility armor="5264" attack="2622" base="186" critHitPercent="30.11" effective="2632"/>
        class Agility
          # Character's base Agility stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Agility, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Amount of Armor given by this amount of Agility
          # @return [Integer]
          attr_reader :armor

          # Amount of Attack Power given by this amount of Agility
          # @return [Integer]
          attr_reader :attack

          # Critical hit chance given by this amount of Agility
          # @return [Integer]
          attr_reader :crit_hit_percent

          # @param [Hpricot::Elem] elem <tt>agility</tt> element
          def initialize(elem)
            @base             = elem[:base].to_i
            @effective        = elem[:effective].to_i
            @armor            = elem[:armor].to_i
            @attack           = elem[:attack].to_i == -1 ? nil : elem[:attack].to_i
            @crit_hit_percent = elem[:critHitPercent].to_f
          end
        end
      end
    end
  end
end
