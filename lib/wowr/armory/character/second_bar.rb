module Wowr
  module Armory
    module Character
      # = SecondBar
      #
      # Represents a character's <tt>secondBar</tt> (e.g., focus, mana, rage) element
      #
      # == Relevant XML examples:
      #
      #   <secondBar casting="-1" effective="120" notCasting="-1" type="e"/>
      #
      #   <secondBar casting="-1" effective="100" notCasting="-1" perFive="-1" type="f"/>
      #
      #   <secondBar casting="457" effective="38929" notCasting="695" type="m"/>
      #
      #   <secondBar casting="-1" effective="100" notCasting="-1" perFive="-1" type="p"/>
      #
      #   <secondBar casting="-1" effective="100" notCasting="-1" perFive="-1" type="r"/>
      class SecondBar
        # @return [Integer]
        attr_reader :effective

        # @return [Integer]
        attr_reader :casting

        # @return [Integer]
        attr_reader :not_casting

        # @see Wowr::Armory#power_type
        # @return [String]
        attr_reader :type

        # @param [Nokogiri::XML::Element] elem <tt>secondBar</tt> element
        def initialize(elem)
          @effective    = elem[:effective].to_i
          @casting      = elem[:casting].to_i == -1 ? nil : elem[:casting].to_i
          @not_casting  = elem[:notCasting].to_i == -1 ? nil : elem[:notCasting].to_i
          @type         = elem[:type]
        end
      end
    end
  end
end
