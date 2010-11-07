module Wowr
  module Armory
    module Character
      module Stat
        # = Spirit
        #
        # Represents a <tt>baseStats/spirit</tt> element
        #
        # == Relevant XML example:
        #
        #   <spirit base="168" effective="219" healthRegen="14" manaRegen="170"/>
        class Spirit
          # Character's base Spirit stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Spirit, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Health regeneration given by this amount of Spirit
          # @return [Integer]
          attr_reader :health_regen

          # Mana regeneration given by this amount of Spirit
          # @return [Integer]
          attr_reader :mana_regen

          # @param [Hpricot::Elem] elem <tt>spirit</tt> element
          def initialize(elem)
            @base         = elem[:base].to_i
            @effective    = elem[:effective].to_i
            @health_regen = elem[:healthRegen].to_i
            @mana_regen   = elem[:manaRegen].to_i
          end
        end
      end
    end
  end
end
