module Wowr
  module Armory
    module Character
      module SpellStats
        # = ManaRegen
        #
        # Represents a <tt>spell/manaRegen</tt> element
        #
        # == Relevant XML example:
        #
        #   <manaRegen casting="193.00" notCasting="364.00"/>
        class ManaRegen
          # Regen while casting
          # @return [Float]
          attr_reader :casting

          # Regen while not casting
          # @return [Float]
          attr_reader :not_casting

          # @param [Nokogiri::XML::Element] elem <tt>spell/manaRegen</tt> element
          def initialize(elem)
            @casting      = elem[:casting].to_f
            @not_casting  = elem[:notCasting].to_f
          end
        end
      end
    end
  end
end
