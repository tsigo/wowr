module Wowr
  module Armory
    module Character
      module Spell
        # = Speed
        #
        # Represents a <tt>hasteRating</tt> element
        #
        # == Relevant XML example:
        #
        #   <hasteRating hastePercent="43.37" hasteRating="1422"/>
        class Speed
          # @todo Check naming consistency
          # @return [Float]
          attr_reader :percent_increase

          # @todo Check naming consistency
          # @return [Integer]
          attr_reader :haste_rating

          # @param [Hpricot::Elem] elem <tt>hasteRating</tt> element
          def initialize(elem)
            @percent_increase = elem[:hastePercent].to_f
            @haste_rating     = elem[:hasteRating].to_i
          end
        end
      end
    end
  end
end
