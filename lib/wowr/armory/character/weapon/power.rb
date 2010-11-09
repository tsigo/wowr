module Wowr
  module Armory
    module Character
      module Weapon
        # = Power
        #
        # Represents a <tt>power</tt> element
        #
        # == Relevant XML example:
        #
        #   <power base="5256" effective="5559" increasedDps="397.0"/>
        class Power
          # @return [Integer]
          attr_reader :base

          # @return [Integer]
          attr_reader :effective

          # @return [Float]
          attr_reader :increased_dps

          # @param [Hpricot::Elem] elem <tt>power</tt> element
          def initialize(elem)
            @base          = elem[:base].to_i
            @effective     = elem[:effective].to_i
            @increased_dps = elem[:increasedDps].to_f
          end
        end
      end
    end
  end
end
