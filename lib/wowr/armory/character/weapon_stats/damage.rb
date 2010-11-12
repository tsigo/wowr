module Wowr
  module Armory
    module Character
      module WeaponStats
        # = Damage
        #
        # Represents a <tt>mainHandDamage</tt> or <tt>offHandDamage</tt> element
        #
        # == Relevant XML examples:
        #
        #   <mainHandDamage dps="725.4" max="2380" min="1879" percent="0" speed="2.94"/>
        #
        #   <offHandDamage dps="149.8" max="245" min="244" percent="0" speed="1.63"/>
        class Damage
          # @return [Float]
          attr_reader :dps

          # @return [Integer]
          attr_reader :max

          # @return [Integer]
          attr_reader :min

          # @return [Float]
          attr_reader :percent

          # @return [Float]
          attr_reader :speed

          # @param [Nokogiri::XML::Element] elem
          def initialize(elem)
            @dps     = elem[:dps].to_f
            @max     = elem[:max].to_i
            @min     = elem[:min].to_i
            @percent = elem[:percent].to_f
            @speed   = elem[:speed].to_f
          end
        end
      end
    end
  end
end
