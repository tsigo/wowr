module Wowr
  module Armory
    module Character
      module WeaponStats
        # = Expertise
        #
        # Represents an <tt>expertise</tt> element
        #
        # == Relevant XML example:
        #
        #   <expertise additional="27" percent="6.75" rating="212" value="27"/>
        class Expertise
          # @return [Integer]
          attr_reader :additional

          # @return [Float]
          attr_reader :percent

          # @return [Integer]
          attr_reader :rating

          # @return [Integer]
          attr_reader :value

          # @param [Nokogiri::XML::Element] elem <tt>expertise</tt> element
          def initialize(elem)
            @additional = elem[:additional].to_i
            @percent    = elem[:percent].to_f
            @rating     = elem[:rating].to_i
            @value      = elem[:value].to_i
          end
        end
      end
    end
  end
end
