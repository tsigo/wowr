module Wowr
  module Armory
    module Character
      module WeaponStats
        # = CritChance
        #
        # Represents a <tt>melee/critChance</tt> element
        #
        # == Relevant XML example:
        #
        #   <critChance percent="60.33" plusPercent="29.95" rating="1375"/>
        class CritChance
          # @return [Float]
          attr_reader :percent

          # @return [Float]
          attr_reader :plus_percent

          # @return [Integer]
          attr_reader :rating

          # @param [Nokogiri::XML::Element] elem <tt>critChance</tt> element
          def initialize(elem)
            @percent      = elem[:percent].to_f
            @plus_percent = elem[:plusPercent].to_f
            @rating       = elem[:rating].to_i
          end
        end
      end
    end
  end
end
