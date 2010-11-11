module Wowr
  module Armory
    module Item
      # = CostToken
      #
      # Represents a <tt>cost/token</tt> element
      #
      # == Relevant XML example:
      #
      #   <token count="20" icon="inv_misc_rune_08" id="26045"/>
      class CostToken < Base
        # @return [Integer]
        attr_reader :count

        # @param [Hpricot::Elem] elem <tt>token</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          super(elem, api)

          @count = elem[:count].to_i
        end
      end
    end
  end
end
