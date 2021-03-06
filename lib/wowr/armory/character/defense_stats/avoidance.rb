module Wowr
  module Armory
    module Character
      module DefenseStats
        # = Avoidance
        #
        # Represents a <tt>defenses/dodge</tt>, <tt>defenses/parry</tt> or
        # <tt>defenses/block</tt> element
        #
        # == Relevant XML examples:
        #
        #   <dodge increasePercent="0.00" percent="5.82" rating="0"/>
        #   <parry increasePercent="0.11" percent="5.12" rating="5"/>
        #   <block increasePercent="0.00" percent="5.00" rating="0"/>
        class Avoidance
          # @return [Float]
          attr_reader :percent

          # @return [Float]
          attr_reader :increase_percent

          # @return [Integer]
          attr_reader :rating

          # @param [Nokogiri::XML::Element] elem <tt>dodge</tt>, <tt>parry</tt> or <tt>block</tt> element
          def initialize(elem)
            @percent          = elem[:percent].to_f
            @increase_percent = elem[:increasePercent].to_f
            @rating           = elem[:rating].to_i
          end
        end
      end
    end
  end
end
