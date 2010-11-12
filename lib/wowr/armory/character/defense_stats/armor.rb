module Wowr
  module Armory
    module Character
      module DefenseStats
        # = Armor
        #
        # Represents a <tt>defenses/armor</tt> element
        #
        # == Relevant XML example:
        #
        #   <armor base="12235" effective="12235" percent="44.54" petBonus="4282"/>
        class Armor
          # Character's base Armor stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Armor, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Physical damage reduction given by this amount of Armor
          # @return [Float]
          attr_reader :percent

          # Amount of Armor given to the character's pet
          # @return [Integer]
          attr_reader :pet_bonus

          # @param [Nokogiri::XML::Element] elem <tt>armor</tt> element
          def initialize(elem)
            @base       = elem[:base].to_i
            @effective  = elem[:effective].to_i
            @percent    = elem[:percent].to_f
            @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
