module Wowr
  module Armory
    module Character
      module DefenseStats
        # = Defense
        #
        # Represents a <tt>defenses/defense</tt> element
        #
        # == Relevant XML example:
        #
        #   <defense decreasePercent="0.00" increasePercent="0.00" plusDefense="0" rating="0" value="400.00"/>
        class Defense
          # @todo Unknown purpose
          # @return [Integer]
          attr_reader :value

          # @todo Unknown purpose
          # @return [Float]
          attr_reader :increase_percent

          # @todo Unknown purpose
          # @return [Float]
          attr_reader :decrease_percent

          # @todo Unknown purpose
          # @return [Integer]
          attr_reader :plus_defense

          # @todo Unknown purpose
          # @return [Integer]
          attr_reader :rating

          # @param [Hpricot::Elem] elem <tt>defense</tt> element
          def initialize(elem)
            @value            = elem[:value].to_i
            @increase_percent = elem[:increasePercent].to_f
            @decrease_percent = elem[:decreasePercent].to_f
            @plus_defense     = elem[:plusDefense].to_i
            @rating           = elem[:rating].to_i
          end
        end
      end
    end
  end
end
