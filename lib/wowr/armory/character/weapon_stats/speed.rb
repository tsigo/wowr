module Wowr
  module Armory
    module Character
      module WeaponStats
        # = Speed
        #
        # Represents a <tt>mainHandSpeed</tt> or <tt>offHandSpeed</tt> element
        #
        # == Relevant XML example:
        #
        #   <mainHandSpeed hastePercent="22.60" hasteRating="741" value="2.94"/>
        #
        #   <offHandSpeed hastePercent="22.60" hasteRating="741" value="1.63"/>
        class Speed
          # @return [Float]
          attr_reader :haste_percent

          # @return [Integer]
          attr_reader :haste_rating

          # @return [Float]
          attr_reader :value

          # @param [Nokogiri::XML::Element] elem
          def initialize(elem)
            @haste_percent = elem[:hastePercent].to_f
            @haste_rating  = elem[:hasteRating].to_i
            @value         = elem[:value].to_f
          end
        end
      end
    end
  end
end
