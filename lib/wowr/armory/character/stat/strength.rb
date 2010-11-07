module Wowr
  module Armory
    module Character
      module Stat
        # = Strength
        #
        # Represents a <tt>baseStats/strength</tt> element
        #
        # == Relevant XML example:
        #
        #   <strength attack="316" base="148" block="8" effective="168"/>
        class Strength
          # Character's base Strength stat, before bonuses
          # @return [Integer]
          attr_reader :base

          # Character's effective Strength, after bonuses
          # @return [Integer]
          attr_reader :effective

          # Amount of attack power given by this amount of Strength
          # @return [Integer]
          attr_reader :attack

          # Amount of block given by this amount of Strength
          # @return [Integer]
          attr_reader :block

          def initialize(elem)
            @base       = elem['base'].to_i
            @effective  = elem['effective'].to_i
            @attack     = elem['attack'].to_i
            @block      = elem['block'].to_i == -1 ? nil : elem['block'].to_i
          end
        end
      end
    end
  end
end
